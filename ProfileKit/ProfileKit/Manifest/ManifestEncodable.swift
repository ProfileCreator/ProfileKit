//
//  ManifestEncodable.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-14.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension Manifest: Encodable {
    public func encode(to encoder: Encoder) throws {

        // Get the encoding container
        var container = encoder.container(keyedBy: ManifestKey.self)

        // Encode Required Values
        try container.encode(self.description, forKey: .description)
        try container.encode(self.domain, forKey: .domain)
        try container.encode(self.domainIdentifier, forKey: .domainIdentifier)
        try container.encode(self.formatVersion, forKey: .formatVersion)
        try container.encode(self.interaction, forKey: .interaction)
        try container.encode(self.lastModified, forKey: .lastModified)
        try container.encode(self.platforms, forKey: .platforms)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.unique, forKey: .unique)
        try container.encode(self.version, forKey: .version)

        // Encode Optional Values
        try container.encodeIfPresent(self.appURL, forKey: .appURL)
        try container.encodeIfPresent(self.descriptionReference, forKey: .descriptionReference)
        try container.encodeIfPresent(self.documentationURL, forKey: .documentationURL)
        try container.encodeIfPresent(self.icon, forKey: .icon)
        try container.encodeIfPresent(self.iOSDeprecated, forKey: .iOSDeprecated)
        try container.encodeIfPresent(self.iOSMax, forKey: .iOSMax)
        try container.encodeIfPresent(self.iOSMin, forKey: .iOSMin)
        try container.encodeIfPresent(self.macOSDeprecated, forKey: .macOSDeprecated)
        try container.encodeIfPresent(self.macOSMax, forKey: .macOSMax)
        try container.encodeIfPresent(self.macOSMin, forKey: .macOSMin)
        try container.encodeIfPresent(self.note, forKey: .note)
        try container.encodeIfPresent(self.requireSupervision, forKey: .requireSupervision)
        try container.encodeIfPresent(self.requireUserApprovedMDM, forKey: .requireUserApprovedMDM)
        try container.encodeIfPresent(self.subdomain, forKey: .subdomain)
        try container.encodeIfPresent(self.substitutionVariables, forKey: .substitutionVariables)
        try container.encodeIfPresent(self.targets, forKey: .targets)
        try container.encodeIfPresent(self.tvOSDeprecated, forKey: .tvOSDeprecated)
        try container.encodeIfPresent(self.tvOSMax, forKey: .tvOSMax)
        try container.encodeIfPresent(self.tvOSMin, forKey: .tvOSMin)
    }
}
