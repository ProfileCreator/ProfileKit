//
//  main.swift
//  ProfileKitExample
//
//  Created by Erik Berglund on 2019-05-01.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation
import ProfileKit
import Cocoa

do {
/*
    if let merged = try InstalledProfiles.all() {
        Swift.print("*** Merged ***")
        let mergedOutputData = try PropertyListSerialization.data(fromPropertyList: merged, format: .xml, options: 0)
        FileHandle.standardOutput.write(mergedOutputData)
    }

    let configuURL = URL(fileURLWithPath: "/Users/erikberglund/Desktop/com.apple.TCC.configuration-profile-policy.mobileconfig")

    let configuData = try Data(contentsOf: configuURL)

    let conig = try PropertyListDecoder().decode(Profile.self, from: configuData)

    if let payload = conig.payloadContent?.first {
        Swift.print("Paload: \(payload)")
    }
*/
    let categories = Set([Manifest.Category.applePayload])
    Manifests.shared.initialize(categories: categories)
    for manifest in try Manifests.shared.manifests(forCategory: .applePayload) {
        Swift.print("manifest: \(manifest)")
        Swift.print("manifest.interaction: \(manifest.interaction)")
        Swift.print("manifest.title: \(manifest.title)")
        Swift.print("manifest.domainIdentifier: \(manifest.domainIdentifier)")
        Swift.print("manifest.manifestURL: \(manifest.manifestURL)")
    }

    Swift.print("categories: \(Manifests.shared.categories)")
/*
    let manifestURL = URL(fileURLWithPath: "/Users/erikberglund/Library/Application Support/ProfilePayloads/Manifests/ManifestsApple/com.apple.TCC.configuration-profile-policy.plist")
    let manifestData = try Data(contentsOf: manifestURL)

    let manifest = try PropertyListDecoder().decode(Manifest.self, from: manifestData)
    manifest.manifestURL = manifestURL
    // manifest.manifest = manifestData.plist()

    Swift.print("manifest: \(manifest)")
    Swift.print("manifest.interaction: \(manifest.interaction)")
    Swift.print("manifest.title: \(manifest.title)")
    Swift.print("manifest.domainIdentifier: \(manifest.domainIdentifier)")
    Swift.print("manifest.manifestURL: \(manifest.manifestURL)")
    for subkey in manifest.subkeys ?? [] {
        Swift.print("subkey: \(subkey.name)")
        for subsubkey in subkey.subkeys {
            Swift.print("subsubkey: \(subsubkey.name) - \(subsubkey.type)")
            for subsubsubkey in subsubkey.subkeys {
                Swift.print("subsubsubkey: \(subsubsubkey.name) - \(subsubsubkey.type)")
                for subsubsubsubkey in subsubsubkey.subkeys {
                    Swift.print("subsubsubsubkey: \(subsubsubsubkey.name) - \(subsubsubsubkey.type)")
                }
            }
        }
    }
*/
    /*
    Swift.print("*** MDMClient ***")
    let all = try MDMClient.installedProfiles()
    let outputData = try PropertyListSerialization.data(fromPropertyList: all, format: .xml, options: 0)
    FileHandle.standardOutput.write(outputData)

    Swift.print("*** Profiles ***")
    let profiles = try Profiles.show()
    let profilesOutputData = try PropertyListSerialization.data(fromPropertyList: profiles, format: .xml, options: 0)
    FileHandle.standardOutput.write(profilesOutputData)
 */
} catch {
    Swift.print("error: \(error)")
}

