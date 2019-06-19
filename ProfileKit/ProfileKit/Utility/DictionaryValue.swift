//
//  DictionaryValue.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

internal func value<K: ProfileKeyProtocol>(_ value: Any, attemptingToCastAsTypeForKey key: K?) -> Any {
    guard let k = key else { return valueAttemtingToGuessType(value) }
    return ProfileKit.value(value, attemptingToCastAsType: k.valueType)
}

internal func value(_ value: Any, attemptingToCastAsType type: Dictionary<String, Any>.ValueType) -> Any {
    if value is String, let stringValue = value as? String {
        return ProfileKit.value(stringValue: stringValue, attemptingToCastAsType: type)
    }
    return valueAttemtingToGuessType(value)
}

internal func value(stringValue: String, attemptingToCastAsType type: Dictionary<String, Any>.ValueType) -> Any {
    switch type {
    case .bool:
        return NSString(string: stringValue).boolValue
    case .data:
        return Data(withHexString: stringValue.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "", options: .regularExpression))
    case .date:
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: stringValue) ?? stringValue
    case .float:
        return Float(stringValue) ?? stringValue
    case .integer:
        return Int(stringValue) ?? stringValue
    default:
        return stringValue
    }
}

internal func valueAttemtingToGuessType(_ value: Any) -> Any {
    if let stringValue = value as? String {
        if stringValue.range(of: "^<[a-zA-Z0-9 ]+>$", options: .regularExpression) != nil {
            return ProfileKit.value(stringValue: stringValue, attemptingToCastAsType: .data)
        }
    }
    return value
}
