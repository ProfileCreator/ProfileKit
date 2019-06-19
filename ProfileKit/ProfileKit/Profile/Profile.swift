//
//  Profile.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class Profile {

    // MARK: -
    // MARK: Variables Constant

    public let payloadType = "Configuration"

    // MARK: -
    // MARK: Variables Required

    public var payloadIdentifier: String
    public var payloadUUID: String
    public var payloadVersion: Int

    // MARK: -
    // MARK: Variables Optional

    public var durationUntilRemoval: Float?
    public var payloadContent: [Payload]?
    public var payloadDescription: String?
    public var payloadDisplayName: String?
    public var payloadExpirationDate: Date?
    public var payloadOrganization: String?
    public var payloadRemovalDisallowed: Bool?
    public var payloadScope: String?
    public var removalDate: Date?
    public var consentText: [String: String]?

    // MARK: -
    // MARK: Initialization

    init() {
        let uuid = UUID()
        self.payloadIdentifier = uuid.uuidString
        self.payloadUUID = uuid.uuidString
        self.payloadVersion = 1
    }

    public required init(from decoder: Decoder) throws {

        // Get the decoder container
        let container = try decoder.container(keyedBy: ProfileKey.self)

        // Decode Required Values
        self.payloadIdentifier = try container.decode(String.self, forKey: .payloadIdentifier)
        self.payloadUUID = try container.decode(String.self, forKey: .payloadUUID)
        self.payloadVersion = try container.decodeIfPresent(Int.self, forKey: .payloadVersion) ?? 1

        // Decode Optional Values
        try self.decode(from: container)
    }
}

// MARK: -
// MARK: Extension - Decodable

extension Profile: Decodable {
    private func decode(from container: KeyedDecodingContainer<ProfileKey>) throws {
        self.durationUntilRemoval = try container.decodeIfPresent(Float.self, forKey: .durationUntilRemoval)
        self.payloadContent = try container.decodeIfPresent([Payload].self, forKey: .payloadContent)
        self.payloadDescription = try container.decodeIfPresent(String.self, forKey: .payloadDescription)
        self.payloadDisplayName = try container.decodeIfPresent(String.self, forKey: .payloadDisplayName)
        self.payloadOrganization = try container.decodeIfPresent(String.self, forKey: .payloadOrganization)
        self.payloadExpirationDate = try container.decodeIfPresent(Date.self, forKey: .payloadExpirationDate)
        self.payloadRemovalDisallowed = try container.decodeIfPresent(Bool.self, forKey: .payloadRemovalDisallowed)
        self.payloadScope = try container.decodeIfPresent(String.self, forKey: .payloadScope)
        self.removalDate = try container.decodeIfPresent(Date.self, forKey: .removalDate)
        self.durationUntilRemoval = try container.decodeIfPresent(Float.self, forKey: .durationUntilRemoval)
        self.consentText = try container.decodeIfPresent([String: String].self, forKey: .consentText)
    }
}

// MARK: -
// MARK: Extension - Encodable

extension Profile: Encodable {
    public func encode(to encoder: Encoder) throws {

        // Get the encoding container
        var container = encoder.container(keyedBy: ProfileKey.self)

        // Encode Required Values
        try container.encode(self.payloadIdentifier, forKey: .payloadIdentifier)
        try container.encode(self.payloadUUID, forKey: .payloadUUID)
        try container.encode(self.payloadVersion, forKey: .payloadVersion)

        // Encode Optional Values
        try container.encodeIfPresent(self.payloadContent, forKey: .payloadContent)
        try container.encodeIfPresent(self.durationUntilRemoval, forKey: .durationUntilRemoval)
        try container.encodeIfPresent(self.payloadDescription, forKey: .payloadDescription)
        try container.encodeIfPresent(self.payloadDisplayName, forKey: .payloadDisplayName)
        try container.encodeIfPresent(self.payloadOrganization, forKey: .payloadOrganization)
        try container.encodeIfPresent(self.payloadExpirationDate, forKey: .payloadExpirationDate)
        try container.encodeIfPresent(self.payloadRemovalDisallowed, forKey: .payloadRemovalDisallowed)
        try container.encodeIfPresent(self.payloadScope, forKey: .payloadScope)
        try container.encodeIfPresent(self.removalDate, forKey: .removalDate)
        try container.encodeIfPresent(self.durationUntilRemoval, forKey: .durationUntilRemoval)
        try container.encodeIfPresent(self.consentText, forKey: .consentText)
    }
}
