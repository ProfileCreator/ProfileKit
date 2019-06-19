//
//  ManifestController.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-17.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

internal class ManifestController {

    // MARK: -
    // MARK: Static Variables

    // MARK: -
    // MARK: Required Variables

    let category: Manifest.Category
    var manifests = Set<Manifest>()

    // MARK: -
    // MARK: Initialization

    init(category: Manifest.Category) {
        Swift.print("Initializing manifest controller for category: \(category)")
        self.category = category
        do {
            try self.updateManifests()
        } catch {
            // FIXME: Proper Error
            Swift.print("Error: \(error)")
        }
    }

    // MARK: -
    // MARK: Update Manifests

    func updateManifests() throws {
        Swift.print("Updating manifests for controller with category: \(category)")
        var updatedManifests = Set<Manifest>()
        for directoryRoot in ManifestController.DirectoryRoot.allCases {
            Swift.print("Getting manifest for directory root: \(directoryRoot)")
            guard let directoryURL = try self.directory(forType: .manifests, root: directoryRoot, create: false) else { continue }
            try self.addManifests(fromURL: directoryURL, to: &updatedManifests)
        }
        self.manifests = updatedManifests
    }

    private func addManifests(fromURL url: URL, to manifests: inout Set<Manifest>) throws {
        let manifestURLs = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        for manifestURL in manifestURLs.filter({ $0.pathExtension == "plist" }) {
            do {
                let manifestData = try Data(contentsOf: manifestURL)
                let manifest = try PropertyListDecoder().decode(Manifest.self, from: manifestData)

                // Verify this manifest is supported by this version of the framework
                guard manifest.formatVersion <= Manifest.formatVersionSupported else {
                    // FIXME: Proper Logging
                    Swift.print("Manifest with domain identifier: \(manifest.domainIdentifier) was not included as it's format version was not supported.")
                    Swift.print("Manifest format version: \(manifest.formatVersion)")
                    Swift.print("Supported format version: \(Manifest.formatVersionSupported)")
                    continue
                }

                // Verify only the latest version of a specific manifest i loaded
                if let existingManifest = manifests.first(where: { $0.domainIdentifier == manifest.domainIdentifier }) {
                    if existingManifest.version < manifest.version || ( existingManifest.version == manifest.version && existingManifest.lastModified < manifest.lastModified ) {
                        manifests.remove(existingManifest)
                    } else {
                        // FIXME: Proper Logging
                        Swift.print("A newer version of manifest with domain identifier: \(manifest.domainIdentifier) already exists.")
                        Swift.print("Manifest url: \(manifestURL)")
                        Swift.print("Existing manifest url: \(String(describing: existingManifest.manifestURL))")
                        continue
                    }
                }

                // Add external information to manifest
                manifest.category = self.category
                manifest.manifestURL = manifestURL

                // Initialize variaables
                manifest.intializeVariables()

                // FIXME: Add Override Here

                manifests.insert(manifest)
            } catch {
                // FIXME: Proper Logging
                Swift.print("Error while decoding manifest from url: \(manifestURL)")
                Swift.print("Error: \(error)")
                continue
            }
        }
    }
}

// MARK: -
// MARK: Hashable

extension ManifestController: Hashable {
    static func == (lhs: ManifestController, rhs: ManifestController) -> Bool {
        return lhs.category == rhs.category
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(category)
    }
}
