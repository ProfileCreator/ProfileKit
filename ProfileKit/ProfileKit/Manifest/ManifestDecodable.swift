//
//  ManifestDecodable.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-14.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension Manifest: Decodable {
    internal func decode(from container: KeyedDecodingContainer<ManifestKey>) throws {
        self.appURL = try container.decodeIfPresent(String.self, forKey: .appURL)
        self.descriptionReference = try container.decodeIfPresent(String.self, forKey: .descriptionReference)
        self.documentationURL = try container.decodeIfPresent(String.self, forKey: .documentationURL)
        self.icon = try container.decodeIfPresent(Data.self, forKey: .icon)
        self.iOSDeprecated = try container.decodeIfPresent(String.self, forKey: .iOSDeprecated)
        self.iOSMax = try container.decodeIfPresent(String.self, forKey: .iOSMax)
        self.iOSMin = try container.decodeIfPresent(String.self, forKey: .iOSMin)
        self.macOSDeprecated = try container.decodeIfPresent(String.self, forKey: .macOSDeprecated)
        self.macOSMax = try container.decodeIfPresent(String.self, forKey: .macOSMax)
        self.macOSMin = try container.decodeIfPresent(String.self, forKey: .macOSMin)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.requireSupervision = try container.decodeIfPresent(Bool.self, forKey: .requireSupervision) ?? false
        self.requireUserApprovedMDM = try container.decodeIfPresent(Bool.self, forKey: .requireUserApprovedMDM) ?? false
        self.subdomain = try container.decodeIfPresent(String.self, forKey: .subdomain)
        self.substitutionVariables = try container.decodeIfPresent([String: [String: String]].self, forKey: .substitutionVariables)
        self.subkeys = try container.decodeIfPresent([ManifestSubkey].self, forKey: .subkeys) ?? [ManifestSubkey]()
        self.targets = try container.decodeIfPresent([String].self, forKey: .targets)
        self.tvOSDeprecated = try container.decodeIfPresent(String.self, forKey: .tvOSDeprecated)
        self.tvOSMax = try container.decodeIfPresent(String.self, forKey: .tvOSMax)
        self.tvOSMin = try container.decodeIfPresent(String.self, forKey: .tvOSMin)
    }
}
