//
//  ManifestSubkeyEncodable.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-14.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension ManifestSubkey: Encodable {
    public func encode(to encoder: Encoder) throws {

        // Get the encoding container
        var container = encoder.container(keyedBy: ManifestSubkeyKey.self)

        // Encode Required Values
        try container.encode(self.name, forKey: .name)
        try container.encode(self.type, forKey: .type)
    }
}
