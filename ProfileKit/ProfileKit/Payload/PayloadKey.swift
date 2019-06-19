//
//  PayloadKey.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public enum PayloadKey: String, CodingKey, CaseIterable {

    /**
     Optional. A human-readable description of this payload.

     This description is shown on the Detail screen.
     */
    case payloadDescription

    /**
     A human-readable name for the profile payload.

     This name is displayed on the Detail screen. It does not have to be unique.
     */
    case payloadDisplayName

    /**
     A reverse-DNS-style identifier for the specific payload.

     It is usually the same identifier as the root-level PayloadIdentifier value with an additional component appended.
     */
    case payloadIdentifier

    /**
     Optional. A human-readable string containing the name of the organization that provided the profile.
     
     The payload organization for a payload need not match the payload organization in the enclosing profile.
     */
    case payloadOrganization

    /**
     A globally unique identifier for the payload.

     The actual content is unimportant, but it must be globally unique. In macOS, you can use uuidgen to generate reasonable UUIDs.
     */
    case payloadUUID

    /**
     The payload type.
     */
    case payloadType

    /**
     The version number of the individual payload.
     
     A profile can consist of payloads with different version numbers. For example, changes to the VPN software in iOS might introduce a new payload version to support additional features, but Mail payload versions would not necessarily change in the same release.
     */
    case payloadVersion
}

// MARK: -
// MARK: Extension - RawRepresentable

extension PayloadKey: RawRepresentable {
    public typealias RawValue = String
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "PayloadDescription":  self = .payloadDescription
        case "PayloadDisplayName",
             "Name":                self = .payloadDisplayName
        case "PayloadIdentifier",
             "Identifier":          self = .payloadIdentifier
        case "PayloadOrganization": self = .payloadOrganization
        case "PayloadType",
             "Type":                self = .payloadType
        case "PayloadUUID",
             "UUID":                self = .payloadUUID
        case "PayloadVersion":      self = .payloadVersion
        default:                    return nil
        }
    }
}

// MARK: -
// MARK: Extension - rawValue

public extension PayloadKey {
    var rawValue: RawValue {
        switch self {
        case .payloadDescription:   return "PayloadDescription"
        case .payloadDisplayName:   return "PayloadDisplayName"
        case .payloadIdentifier:    return "PayloadIdentifier"
        case .payloadOrganization:  return "PayloadOrganization"
        case .payloadUUID:          return "PayloadUUID"
        case .payloadType:          return "PayloadType"
        case .payloadVersion:       return "PayloadVersion"
        }
    }
}

// MARK: -
// MARK: Extension - ProfileKeyProtocol

extension PayloadKey: ProfileKeyProtocol {
    public var valueType: Dictionary<String, Any>.ValueType {
        switch self {
        case .payloadDescription:   return .string
        case .payloadDisplayName:   return .string
        case .payloadIdentifier:    return .string
        case .payloadOrganization:  return .string
        case .payloadType:          return .string
        case .payloadUUID:          return .string
        case .payloadVersion:       return .integer
        }
    }

    public var rawValues: [RawValue] {
        switch self {
        case .payloadDisplayName:   return [self.rawValue, "Name"]
        case .payloadIdentifier:    return [self.rawValue, "Identifier"]
        case .payloadType:          return [self.rawValue, "Type"]
        case .payloadUUID:          return [self.rawValue, "UUID"]

        // All that doesn't have multiple values, just return rawValue
        default:                    return [self.rawValue]
        }
    }
}
