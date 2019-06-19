//
//  Manifest.Directory.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-17.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension ManifestController {

    enum DirectoryRoot: CaseIterable {
        case applicationSupport
        case custom
        case bundle
    }

    enum DirectoryType: String, CaseIterable {
        case manifests = "Manifests"
        case manifestOverrides = "ManifestOverrides"
        case icons = "Icons"
        case iconOverrides = "IconOverrides"
    }

    func directory(forType type: ManifestController.DirectoryType, root: ManifestController.DirectoryRoot, create: Bool) throws -> URL? {
        guard
            let directoryName = self.directoryName,
            let typeURL = try directory(forType: type, root: root) else { return nil }
        let directoryURL = typeURL.appendingPathComponent(directoryName, isDirectory: true)
        if create {
            try FileManager.default.createDirectoryIfNotExists(at: directoryURL, withIntermediateDirectories: true)
        }
        return directoryURL
    }

    private func directory(forType type: ManifestController.DirectoryType, root: ManifestController.DirectoryRoot) throws -> URL? {
        do {
            let rootURL = try self.directory(forRoot: root)
            return rootURL?.appendingPathComponent(type.rawValue, isDirectory: true)
        } catch {
            // FIXME: Proper Error
            Swift.print("Failed to get root URL for \(root)")
        }
        return nil
    }

    private func directory(forRoot root: ManifestController.DirectoryRoot) throws -> URL? {
        switch root {
        case .applicationSupport:
            let applicationSupportURL = try FileManager.default.url(for: .applicationSupportDirectory,
                                                                    in: .userDomainMask,
                                                                    appropriateFor: nil,
                                                                    create: false)
            return applicationSupportURL.appendingPathComponent("ProfilePayloads", isDirectory: true)
        case .bundle:
            return Bundle(for: Manifests.self).bundleURL.appendingPathComponent("Resources", isDirectory: true)
        case .custom:
            if let customPath = UserDefaults.standard.string(forKey: PreferenceKey.manifestDirectoryRootPath) {
                return URL(fileURLWithPath: customPath)
            }
        }
        return nil
    }

    var directoryName: String? {
        switch self.category {
        case .applePayload:
            return "ManifestsApple"
        case .applePreference:
            return ""
        case .custom:
            return ""
        case .preference:
            return ""
        case .unknown:
            return nil
        }
    }
}
