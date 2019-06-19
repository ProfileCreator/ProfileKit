//
//  ParserShow.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-04-30.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension ProfilesCommand {
    static func show() throws -> [String: [[String: Any]]] {
        var installedProfiles = [String: [[String: Any]]]()

        // Set the default arguments for the command
        var args = ["show", "--output", "stdout-xml"]

        // If this is run with administrator privileges, add --all to show all profiles
        if getuid() == 0 { args.append("--all") }

        // Run the command show
        let data = try Command.run(path: self.path, arguments: args)

        // Convert the output to a dictionary
        guard let plist = try Command.plistFromOutputStringData(data) as? [String: [[String: Any]]] else {
            Swift.print("Failed to decode output from \(self.path): \(String(describing: String(data: data, encoding: .utf8)))")
            return installedProfiles
        }

        // Loop through the output dictionary and update all payload keys using InstalledProfileKey
        for (scopeKey, scopeProfiles) in plist {
            var updatedProfiles = [[String: Any]]()

            // Determine if the scope is System or User
            let scopeKeyName = scopeKey == "_computerlevel" ? "System" : "User"

            for scopeProfile in scopeProfiles {

                // Update keys and values for the profile using the InstalledProfileKey enum keys
                var updatedProfile = self.updateDictionary(scopeProfile, withKeyType: InstalledProfileKey.self)

                // If this is the User scope, add the Username and UID for the user the profile is installed for
                if scopeKeyName == "User"{
                    var internalData = updatedProfile[InstalledProfileKey.internalData.rawValue] as? [String: Any] ?? [String: Any]()
                    internalData[InstalledProfileKey.installedForUser.rawValue] = scopeKey
                    internalData[InstalledProfileKey.installedForUID.rawValue] = getpwnam(scopeKey)?.pointee.pw_uid ?? -1
                    updatedProfile[InstalledProfileKey.internalData.rawValue] = internalData
                }

                // Add PayloadScope to the profile
                updatedProfile[InstalledProfileKey.payloadScope.rawValue] = scopeKeyName

                // Add the updated profile to the array
                updatedProfiles.append(updatedProfile)
            }

            // Add the updated profiles to the installed profiles dict
            var installedScopeProfiles = installedProfiles[scopeKeyName] ?? [[String: Any]]()
            installedScopeProfiles.append(contentsOf: updatedProfiles)
            installedProfiles[scopeKeyName] = installedScopeProfiles
        }

        return installedProfiles
    }

    private static func updateArray<T: RawRepresentable & ProfileKeyProtocol>(_ array: [Any], withKeyType keyType: T.Type) -> [Any] where T.RawValue == String {
        var newArray = [Any]()
        for value in array {
            newArray.append(self.updateProfileValue(value, keyEnum: nil, withKeyType: keyType))
        }
        return newArray
    }

    private static func updateDictionary<T: RawRepresentable & ProfileKeyProtocol>(_ dict: [String: Any], withKeyType keyType: T.Type) -> [String: Any] where T.RawValue == String {
        var newDict = [String: Any]()
        for (key, value) in dict {

            // Get the keyEnum if the key matches
            let keyEnum = keyType.init(rawValue: key)
            let keyString = keyEnum?.rawValue ?? key.trimmingCharacters(in: CharacterSet(charactersIn: "\""))

            // Log any key that's not available in the key enym
            if keyEnum == nil { Swift.print("No case in \(keyType.self) for: \(keyString)") }

            // Don't update keys for PayloadContent
            if key == InstalledProfileKey.payloadContent.rawValue {

                // Remove extra PayloadContentManagedPreferences key/dict from PayloadContent for mcx profiles
                if let payloadContent = value as? [String: Any], let payloadContentManagedPreferences = payloadContent["PayloadContentManagedPreferences"] as? [String: Any] {
                    newDict[keyString] = payloadContentManagedPreferences
                } else {
                    newDict[keyString] = value
                }
                continue
            }

            // If these keys are the special profiles keys, add them to a created InternalData key
            if [InstalledProfileKey.installDate.rawValue,
                InstalledProfileKey.verificationState.rawValue].contains(keyString) {
                var internalData = newDict[InstalledProfileKey.internalData.rawValue] as? [String: Any] ?? [String: Any]()
                internalData[keyString] = self.updateProfileValue(value, keyEnum: keyEnum, withKeyType: keyType)
                newDict[InstalledProfileKey.internalData.rawValue] = internalData
                continue
            }

            // Update value (and possible keys if it's a collection) and set it to the updated key
            newDict[keyString] = self.updateProfileValue(value, keyEnum: keyEnum, withKeyType: keyType)
        }
        return newDict
    }

    private static func updateProfileValue<T: RawRepresentable & ProfileKeyProtocol>(_ value: Any, keyEnum: T?, withKeyType keyType: T.Type) -> Any where T.RawValue == String {
        if let valueDictionary = value as? [String: Any] {
            return self.updateDictionary(valueDictionary, withKeyType: keyType)
        } else if let valueArray = value as? [Any] {
            return self.updateArray(valueArray, withKeyType: keyType)
        } else {
            return ProfileKit.value(value, attemptingToCastAsTypeForKey: keyEnum)
        }
    }
}
