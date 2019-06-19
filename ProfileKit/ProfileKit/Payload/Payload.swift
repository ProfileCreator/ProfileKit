//
//  Payload.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class Payload {

    // MARK: -
    // MARK: Variables Static

    public static let commonKeys = [PayloadKey.payloadDescription.rawValue,
                                    PayloadKey.payloadDisplayName.rawValue,
                                    PayloadKey.payloadIdentifier.rawValue,
                                    PayloadKey.payloadType.rawValue,
                                    PayloadKey.payloadUUID.rawValue,
                                    PayloadKey.payloadVersion.rawValue,
                                    PayloadKey.payloadOrganization.rawValue]

    // MARK: -
    // MARK: Variables Required

    public var payloadIdentifier: String
    public var payloadUUID: String
    public var payloadVersion: Int

    // MARK: -
    // MARK: Variables Optional

    public var payloadContent: [PayloadSubkey]?
    public var payloadDescription: String?
    public var payloadDisplayName: String?
    public var payloadOrganization: String?
    public var payloadType: String?

    // MARK: -
    // MARK: Initialization

    init(identifier: String, uuid: String) {
        self.payloadIdentifier = identifier
        self.payloadUUID = uuid
        self.payloadVersion = 1
    }

    public required init(from decoder: Decoder) throws {

        // Get the decoder container
        let container = try decoder.container(keyedBy: PayloadKey.self)

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

extension Payload: Decodable {
    private func decode(from container: KeyedDecodingContainer<PayloadKey>) throws {
        self.payloadDescription = try container.decodeIfPresent(String.self, forKey: .payloadDescription)
        self.payloadDisplayName = try container.decodeIfPresent(String.self, forKey: .payloadDisplayName)
        self.payloadOrganization = try container.decodeIfPresent(String.self, forKey: .payloadOrganization)
        self.payloadType = try container.decodeIfPresent(String.self, forKey: .payloadType)
    }
}

// MARK: -
// MARK: Extension - Encodable

extension Payload: Encodable {
    public func encode(to encoder: Encoder) throws {

        // Get the encoding container
        var container = encoder.container(keyedBy: PayloadKey.self)

        // Encode Required Values
        try container.encode(self.payloadIdentifier, forKey: .payloadIdentifier)
        try container.encode(self.payloadUUID, forKey: .payloadUUID)
        try container.encode(self.payloadVersion, forKey: .payloadVersion)

        // Encode Optional Values
        try container.encodeIfPresent(self.payloadDescription, forKey: .payloadDescription)
        try container.encodeIfPresent(self.payloadDisplayName, forKey: .payloadDisplayName)
        try container.encodeIfPresent(self.payloadOrganization, forKey: .payloadOrganization)
        try container.encodeIfPresent(self.payloadType, forKey: .payloadType)
    }
}
