//
//  Manifest.Category.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-14.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension Manifest {
    enum Category: String, Codable {
        case unknown
        case applePayload
        case applePreference
        case preference
        case custom

        init(keyValue: String) {
            self = Manifest.Category(rawValue: keyValue) ?? .unknown
        }
    }
}
