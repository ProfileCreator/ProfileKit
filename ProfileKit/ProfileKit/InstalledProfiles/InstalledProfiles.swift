//
//  InstalledProfiles.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public struct InstalledProfiles {
    public static func all() throws -> [String: [[String: Any]]]? {
        var allProfiles = [String: [[String: Any]]]()

        let mdmClientOutput = try MDMClientCommand.installedProfiles()
        let profilesOutput = try ProfilesCommand.show()

        for scope in [Scope.system.rawValue, Scope.user.rawValue] {
            var scopeProfiles = [[String: Any]]()

            // Get all mdmclient profiles for scope, if none were found add any profiles from the profiles command in the current scope.
            guard let mdmClientScopeProfiles = mdmClientOutput[scope] else {
                if let profilesScopeProfiles = profilesOutput[scope] {
                    allProfiles[scope] = profilesScopeProfiles
                }
                continue
            }

            // Loop through all mdmclient profiles
            for profile in mdmClientScopeProfiles {
                guard let uuid = profile[InstalledProfileKey.payloadUUID.rawValue] as? String else {

                    // FIXME: Proper Logging
                    Swift.print("Found no \(InstalledProfileKey.payloadUUID.rawValue) key in profile: \(profile)")
                    continue
                }

                var scopeProfile = profile

                // Get the index for a profile from the profiles command with the same uuid as the mdmclient profile
                if
                    var profilesScopeProfiles = profilesOutput[scope],
                    let index = profilesScopeProfiles.firstIndex(where: { $0[InstalledProfileKey.payloadUUID.rawValue] as? String == uuid }) {

                    // Merge the two profiles with key/values from the mdmclient profile taking precedence if there are duplicates
                    let profilesScopeProfile = profilesScopeProfiles.remove(at: index)
                    scopeProfile = profile.merging(profilesScopeProfile, uniquingKeysWith: self.mergingProfileContents)
                }

                // Update possible missing payload data for certain payloads
                scopeProfile = self.updatePayloadContent(in: scopeProfile)

                // Add finished profile to the scopeProfiles array
                scopeProfiles.append(scopeProfile)
            }

            allProfiles[scope] = scopeProfiles
        }

        return allProfiles
    }

    /// Function for the merging profile contents
    private static func mergingProfileContents(_ current: Any, _ new: Any) -> Any {

        // Return the current value, unless the value typs is a dictionary or array, then recursively try to merge their key/values as well.
        if let currentDict = current as? [String: Any], let newDict = new as? [String: Any] {
            return currentDict.merging(newDict, uniquingKeysWith: self.mergingProfileContents)
        } else if let currentArray = current as? [Any], let newArray = new as? [Any] {

            // We're only interested in Payloads here, so if we find a payload with matching UUID in both arrays we merge them
            if let currentDictArray = currentArray as? [[String: Any]], var newDictArray = newArray as? [[String: Any]] {
                var mergedArray = [Any]()

                for dict in currentDictArray {
                    guard let uuid = dict[InstalledProfileKey.payloadUUID.rawValue] as? String else {
                        return newArray
                    }

                    // Get the index for a profile with the same uuid
                    if let index = newDictArray.firstIndex(where: { $0[InstalledProfileKey.payloadUUID.rawValue] as? String == uuid }) {

                        // Merge the two profiles with key/values from the mdmclient profile taking precedence if there are duplicates
                        let profilesScopeProfile = newDictArray.remove(at: index)
                        mergedArray.append(dict.merging(profilesScopeProfile, uniquingKeysWith: self.mergingProfileContents))
                    } else {
                        mergedArray.append(dict)
                    }
                }

                return mergedArray
            } else {
                return newArray
            }
        }
        return current
    }
}
