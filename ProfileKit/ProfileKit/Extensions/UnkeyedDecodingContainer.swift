//
//  UnkeyedDecodingContainer.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-12.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public extension UnkeyedDecodingContainer {

    // Based on: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func decode<T>(_ type: T.Type) throws -> T {
        if let value = try? decode(Bool.self) { return value as! T }
        if let value = try? decode(Double.self) { return value as! T }
        if let value = try? decode(Float.self) { return value as! T }
        if let value = try? decode(Int.self) { return value as! T }
        if let value = try? decode(Int16.self) { return value as! T }
        if let value = try? decode(Int32.self) { return value as! T }
        if let value = try? decode(Int64.self) { return value as! T }
        if let value = try? decode(Int8.self) { return value as! T }
        if let value = try? decode(UInt.self) { return value as! T }
        if let value = try? decode(UInt16.self) { return value as! T }
        if let value = try? decode(UInt32.self) { return value as! T }
        if let value = try? decode(UInt64.self) { return value as! T }
        if let value = try? decode(UInt8.self) { return value as! T }
        if let value = try? decode(String.self) { return value as! T }
        if let value = try? decode(Date.self) { return value as! T }
        if let value = try? decode(Data.self) { return value as! T }
        if let value = try? decodeArray(Any.self) { return value as! T }
        if let value = try? decodeMap(Any.self) { return value as! T }
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Data is not decodable"))
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func decodeArray<T>(_ type: T.Type) throws -> [T] {
        var tmpArray = [T]()
        var nestedContainer = try nestedUnkeyedContainer()
        while !nestedContainer.isAtEnd {
            tmpArray.append(try nestedContainer.decode(T.self))
        }
        return tmpArray
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    mutating func decodeMap<T>(_ type: T.Type) throws -> [String: T] {
        var map: [String: T] = [:]
        let container = try nestedContainer(keyedBy: String.self)
        for key in container.allKeys {
            let value = try container.decode(T.self, forKey: key)
            map[key.stringValue] = value
        }
        return map
    }
}
