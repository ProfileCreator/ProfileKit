//
//  MDMClientCommand.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension MDMClientCommand {
    static func installedProfiles() throws -> [String: [[String: Any]]] {
        var installedProfiles = [String: [[String: Any]]]()

        // Run the command installedProfiles
        let data = try Command.run(path: self.path, arguments: ["installedProfiles"])

        // Parse the returned data line by line
        if let lineReader = LineReader(data: data) {

            var currentProfile = [String: Any]()
            var currentPayload = [String: String]()
            var currentPayloads = [[String: Any]]()

            // var state = StateInstalledProfiles()
            var profileScope: Scope = .system
            var profileLevel: Level = .profile

            var dictLines = [String]()

            var index = 0
            while let line = lineReader.nextLine() {
                // Swift.print("line: \(index): \(line)")
                index += 1
                switch true {

                // This marks the start of a System profile
                case line.contains("* System profile"):
                    profileScope = .system
                    profileLevel = .profile

                // This marks the start of a User profile
                case line.contains("* User profile"):
                    profileScope = .user
                    profileLevel = .profile

                // This marks the start of a payload and the end of the previous dictionary
                case line.contains("... Payload"):
                    if let subDict = NSDictionaryParser.dictionary(forLogRepresentation: dictLines, withKeyType: InstalledProfileKey.self) {
                        switch profileLevel {
                        case .profile:
                            currentProfile = subDict
                        case .payload:
                            currentPayloads.append(subDict)
                        case .none:
                            Swift.print("No profile level set, will NOT save returned dictionary...")
                        }
                    }

                    profileLevel = .payload
                    dictLines = [String]()

                // This marks the end of a profile
                case line.contains("**************************************"):
                    if let subDict = NSDictionaryParser.dictionary(forLogRepresentation: dictLines, withKeyType: InstalledProfileKey.self) {
                        switch profileLevel {
                        case .profile:
                            currentProfile = subDict
                        case .payload:
                            currentPayloads.append(subDict)
                        case .none:
                            Swift.print("No profile level set, will NOT save returned dictionary...")
                        }
                    }

                    // Save the current payload
                    if !currentPayload.isEmpty {
                        currentPayloads.append(currentPayload)
                        currentPayload = [String: String]()
                    }

                    // Save the current payloads
                    if !currentPayloads.isEmpty {
                        currentProfile[ProfileKey.payloadContent.rawValue] = currentPayloads
                        currentPayloads = [[String: Any]]()
                    }

                    // Save the current profile
                    if !currentProfile.isEmpty {
                        var profiles = installedProfiles[profileScope.rawValue] ?? [[String: Any]]()
                        profiles.append(currentProfile)
                        installedProfiles[profileScope.rawValue] = profiles
                    }

                    profileLevel = .none

                // This marks the end of the profile root and start of the payload level
                case line.contains("... Payload"):
                    profileLevel = .payload
                    if !currentPayload.isEmpty {
                        currentPayloads.append(currentPayload)
                        currentPayload = [String: String]()
                    }

                default:
                    if profileLevel != .none {
                        dictLines.append(line)
                    }
                }
            }
        }

        return installedProfiles
    }
}
