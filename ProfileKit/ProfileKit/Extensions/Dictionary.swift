//
//  Dictionary.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    func valueForKey<K: RawRepresentable & ProfileKeyProtocol>(forKey key: K) throws -> Any? where K.RawValue == String {
        guard let value = self[key.rawValue] else { return nil }
        return ProfileKit.value(value, attemptingToCastAsTypeForKey: key)
    }

    public enum ValueType {
        case any
        case array
        case bool
        case date
        case data
        case dictionary
        case float
        case integer
        case string
    }

    // https://gist.github.com/LoganWright/fef555b38c3438565793#gistcomment-2341687
    public func valueForKeyPath(keyPath: String) -> Any? {
        var keys = keyPath.components(separatedBy: ".")
        guard let first = keys.first else {
            Swift.print("Unable to use string as key on type: \(Key.self)")
            return nil
        }
        guard let value = self[first] else {
            return nil
        }
        keys.remove(at: 0)
        if !keys.isEmpty, let subDict = value as? [String: Any] {
            let rejoined = keys.joined(separator: ".")
            return subDict.valueForKeyPath(keyPath: rejoined)
        }
        return value
    }
}
