//
//  Manifest.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class Manifest {

    // MARK: -
    // MARK: Variables Static

    public static let formatVersionSupported = 5

    // MARK: -
    // MARK: Variables Required

    public var description: String
    public var domain: String
    public var domainIdentifier: String
    public var formatVersion: Int
    public var interaction: Manifest.Interaction
    public var lastModified: Date
    public var platforms: [String]
    public var title: String
    public var unique: Bool
    public var version: Int

    // MARK: -
    // MARK: Variables Optional

    public var appURL: String?
    public var descriptionReference: String?
    public var documentationURL: String?
    public var icon: Data?
    public var iOSDeprecated: String?
    public var iOSMax: String?
    public var iOSMin: String?
    public var manifest: [String: Any]?
    public var macOSDeprecated: String?
    public var macOSMax: String?
    public var macOSMin: String?
    public var note: String?
    public var override: String?
    public var requireSupervision: Bool = false
    public var requireUserApprovedMDM: Bool = false
    public var subdomain: String?
    public var substitutionVariables: [String: [String: String]]?
    public var subkeys = [ManifestSubkey]()
    public var targets: [String]?
    public var tvOSDeprecated: String?
    public var tvOSMax: String?
    public var tvOSMin: String?

    // MARK: -
    // MARK: Variables Externally set/Generated

    public var category: Manifest.Category = .unknown
    public var hasOverride: Bool = false
    public var manifestDict: [String: Any]?
    public var manifestURL: URL?
    public var manifestOverride: [String: Any]?
    public var subkeysPayloadContent = [ManifestSubkey]()

    // MARK: -
    // MARK: Initialization

    public required init(from decoder: Decoder) throws {

        // Get the decoder container
        let container = try decoder.container(keyedBy: ManifestKey.self)

        // Decode Required Values
        self.description = try container.decode(String.self, forKey: .description)
        self.domain = try container.decode(String.self, forKey: .domain)
        self.formatVersion = try container.decodeIfPresent(Int.self, forKey: .formatVersion) ?? 1
        self.interaction = try container.decode(Manifest.Interaction.self, forKey: .interaction)
        self.lastModified = try container.decode(Date.self, forKey: .lastModified)
        self.platforms = try container.decode([String].self, forKey: .platforms)
        self.title = try container.decode(String.self, forKey: .title)
        self.unique = try container.decode(Bool.self, forKey: .unique)
        self.version = try container.decode(Int.self, forKey: .version)

        // Decode Optional Values needed for custom Required Values
        if let subdomain = try container.decodeIfPresent(String.self, forKey: .subdomain) {
            self.subdomain = subdomain
            self.domainIdentifier = self.domain + "-" + subdomain
        } else {
            self.domainIdentifier = self.domain
        }

        // Decode Optional Values
        try self.decode(from: container)
    }

    public func intializeVariables() {

        // Add all PayloadContent subkeys to a separate array
        self.subkeysPayloadContent = self.subkeys.filter({ !Payload.commonKeys.contains($0.name) })

        // Update isSinglePayloadContent on any subkey that is the only payload content subkey.
        if self.subkeysPayloadContent.count == 1, let subkey = self.subkeysPayloadContent.first {
            subkey.isSinglePayloadContent = true
        }
    }
}

extension Manifest: Hashable {
    public static func == (lhs: Manifest, rhs: Manifest) -> Bool {
        return lhs.domainIdentifier == rhs.domainIdentifier && rhs.category == lhs.category
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(category)
        hasher.combine(domainIdentifier)
    }
}
