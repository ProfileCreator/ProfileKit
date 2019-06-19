//
//  KeyedDecodingContainerProtocol.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension KeyedDecodingContainerProtocol {
    func decodeStringDate(forKey key: Self.Key) throws -> Date {
        if let date = try self.decodeIfPresent(Date.self, forKey: key) {
            return date
        }
        let stringDate = try self.decode(String.self, forKey: key)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: stringDate) {
            return date
        } else {
            let debugDescription = "The given string was not a valid date string with format: \(String(describing: dateFormatter.dateFormat))"
            let error = DecodingError.Context(codingPath: self.codingPath, debugDescription: debugDescription)
            throw DecodingError.dataCorrupted(error)
        }
    }
}

public extension KeyedDecodingContainerProtocol {

    // Based on: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    func decode<T>(_ type: T.Type, forKey key: Self.Key) throws -> T {
        if let value = try? decode(Bool.self, forKey: key) { return value as! T }
        if let value = try? decode(Double.self, forKey: key) { return value as! T }
        if let value = try? decode(Float.self, forKey: key) { return value as! T }
        if let value = try? decode(Int.self, forKey: key) { return value as! T }
        if let value = try? decode(Int16.self, forKey: key) { return value as! T }
        if let value = try? decode(Int32.self, forKey: key) { return value as! T }
        if let value = try? decode(Int64.self, forKey: key) { return value as! T }
        if let value = try? decode(Int8.self, forKey: key) { return value as! T }
        if let value = try? decode(UInt.self, forKey: key) { return value as! T }
        if let value = try? decode(UInt16.self, forKey: key) { return value as! T }
        if let value = try? decode(UInt32.self, forKey: key) { return value as! T }
        if let value = try? decode(UInt64.self, forKey: key) { return value as! T }
        if let value = try? decode(UInt8.self, forKey: key) { return value as! T }
        if let value = try? decode(String.self, forKey: key) { return value as! T }
        if let value = try? decode(Date.self, forKey: key) { return value as! T }
        if let value = try? decode(Data.self, forKey: key) { return value as! T }
        if let value = try? decodeArray(Any.self, forKey: key) { return value as! T }
        if let value = try? decodeMap(Any.self, forKey: key) { return value as! T }
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Data is not decodable"))
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    func decodeIfPresent<T>(_ type: T.Type, forKey key: Self.Key) throws -> T? {
        guard contains(key) else {
            return nil
        }
        if try decodeNil(forKey: key) {
            return nil
        }
        return try decode(type, forKey: key)
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    fileprivate func decodeArray<T>(_ type: T.Type, forKey key: Self.Key) throws -> [T] {
        var tmpArray = [T]()
        var nestedContainer = try nestedUnkeyedContainer(forKey: key)
        while !nestedContainer.isAtEnd {
            tmpArray.append(try nestedContainer.decode(T.self))
        }
        return tmpArray
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    fileprivate func decodeMap<T>(_ type: T.Type, forKey key: Self.Key) throws -> [String: T] {
        var map: [String: T] = [:]
        let container = try self.nestedContainer(keyedBy: Key.self, forKey: key)
        for key in container.allKeys {
            let value = try container.decode(T.self, forKey: key)
            map[key.stringValue] = value
        }
        return map
    }

    // From: https://gitlab.itnap.ru/open-source/sl-client/swift-sl-client
    func decodeMap<T>(_ type: T.Type, excludedKeys: Set<Self.Key>) throws -> [Self.Key: T] where T: Decodable {
        var map: [Self.Key: T] = [:]

        for key in allKeys {
            if !excludedKeys.contains(key) {
                let value = try decode(T.self, forKey: key)
                map[key] = value
            }
        }

        return map
    }
}
