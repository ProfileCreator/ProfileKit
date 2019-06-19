//
//  ManifestSubkey.Require.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-14.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension ManifestSubkey {
    enum Require: String, Codable {
        case always
        case alwaysNested = "always-nested"
        case push
        case optional

        init(keyValue: String) {
            self = ManifestSubkey.Require(rawValue: keyValue) ?? .optional
        }
    }
}
