//
//  ManifestControllerError.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-17.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

enum ManifestControllerError: Error {
    case unknown
    case noDirectoryNameForCategory(Manifest.Category)
    case noRootURLForDirectoryType(ManifestController.DirectoryRoot)
    case noTypeURLForDirectoryType(ManifestController.DirectoryType)
}

extension ManifestControllerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .noDirectoryNameForCategory(let category):
            return "No directory name for category \(category)."
        case .noRootURLForDirectoryType(let directoryRoot):
            return "No root URL was returned for directory root \(directoryRoot)."
        case .noTypeURLForDirectoryType(let directoryType):
            return "No type URL was returned for directory type \(directoryType)."
        }
    }
}
