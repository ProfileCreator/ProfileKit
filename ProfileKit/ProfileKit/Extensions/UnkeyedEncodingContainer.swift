//
//  UnkeyedEncodingContainer.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-12.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension UnkeyedEncodingContainer {

    // Based on: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func encode<T>(_ value: T) throws {
        if let boolValue = value as? Bool { try encode(boolValue); return }
        if let doubleValue = value as? Double { try encode(doubleValue); return }
        if let floatValue = value as? Float { try encode(floatValue); return }
        if let intValue = value as? Int { try encode(intValue); return }
        if let int16Value = value as? Int16 { try encode(int16Value); return }
        if let int32Value = value as? Int32 { try encode(int32Value); return }
        if let int64Value = value as? Int64 { try encode(int64Value); return }
        if let int8Value = value as? Int8 { try encode(int8Value); return }
        if let uintValue = value as? UInt { try encode(uintValue); return }
        if let uint16Value = value as? UInt16 { try encode(uint16Value); return }
        if let uint32Value = value as? UInt32 { try encode(uint32Value); return }
        if let uint64Value = value as? UInt64 { try encode(uint64Value); return }
        if let uint8Value = value as? UInt8 { try encode(uint8Value); return }
        if let stringValue = value as? String { try encode(stringValue); return }
        if let arrayValue = value as? [Any] {
            var container = nestedUnkeyedContainer()
            for value in arrayValue {
                try container.encode(value)
            }
            return
        }
        if let mapValue = value as? [String: Any] {
            var container = nestedContainer(keyedBy: String.self)
            for (key, value) in mapValue {
                try container.encode(value, forKey: key)
            }
            return
        }
        throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [], debugDescription: "Type is not encodable"))
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func encodeIfPresent<T>(_ value: T?) throws {
        if let value = value {
            try encode(value)
        }
    }
}
