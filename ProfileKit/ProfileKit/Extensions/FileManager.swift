//
//  FileManager.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-17.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension FileManager {
    func createDirectoryIfNotExists(at url: URL, withIntermediateDirectories intermediate: Bool, attributes: [FileAttributeKey: Any]? = nil) throws {
        do {
            try self.createDirectory(at: url, withIntermediateDirectories: intermediate, attributes: attributes)
        } catch {
            if (error as NSError).code != 516 {
                throw error
            }
        }
    }
}
