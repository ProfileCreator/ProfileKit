//
//  ManifestSubkey.Hidden.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-14.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension ManifestSubkey {
    enum Hidden: String, Codable {
        case no
        case all
        case container

        init(keyValue: String) {
            self = ManifestSubkey.Hidden(rawValue: keyValue) ?? .no
        }
    }
}
