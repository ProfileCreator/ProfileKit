//
//  KeyedEncodingContainerProtocol.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-12.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension KeyedEncodingContainerProtocol {

    // Based on: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func encode<T>(_ value: T, forKey key: Self.Key) throws {
        if let boolValue = value as? Bool { try encode(boolValue, forKey: key); return }
        if let doubleValue = value as? Double { try encode(doubleValue, forKey: key); return }
        if let floatValue = value as? Float { try encode(floatValue, forKey: key); return }
        if let intValue = value as? Int { try encode(intValue, forKey: key); return }
        if let int16Value = value as? Int16 { try encode(int16Value, forKey: key); return }
        if let int32Value = value as? Int32 { try encode(int32Value, forKey: key); return }
        if let int64Value = value as? Int64 { try encode(int64Value, forKey: key); return }
        if let int8Value = value as? Int8 { try encode(int8Value, forKey: key); return }
        if let uintValue = value as? UInt { try encode(uintValue, forKey: key); return }
        if let uint16Value = value as? UInt16 { try encode(uint16Value, forKey: key); return }
        if let uint32Value = value as? UInt32 { try encode(uint32Value, forKey: key); return }
        if let uint64Value = value as? UInt64 { try encode(uint64Value, forKey: key); return }
        if let uint8Value = value as? UInt8 { try encode(uint8Value, forKey: key); return }
        if let stringValue = value as? String { try encode(stringValue, forKey: key); return }
        if let stringValue = value as? Date { try encode(stringValue, forKey: key); return }
        if let stringValue = value as? Data { try encode(stringValue, forKey: key); return }
        if let arrayValue = value as? [Any] {
            var container = nestedUnkeyedContainer(forKey: key)
            for singleValue in arrayValue {
                try container.encode(singleValue)
            }
            return
        }
        if let mapValue = value as? [String: Any] {
            var container = nestedContainer(keyedBy: String.self, forKey: key)
            for (key, value) in mapValue {
                try container.encode(value, forKey: key)
            }
            return
        }
        throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [], debugDescription: "Type is not encodable"))
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func encodeIfPresent<T>(_ value: T?, forKey key: Self.Key) throws {
        if let value = value {
            try encode(value, forKey: key)
        }
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func encodeMap<T>(_ pairs: [Self.Key: T]) throws where T: Encodable {
        for (key, value) in pairs {
            try encode(value, forKey: key)
        }
    }
}
