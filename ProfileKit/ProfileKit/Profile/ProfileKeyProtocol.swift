//
//  ProfileKeyProtocol.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public protocol ProfileKeyProtocol {
    associatedtype RawValue

    /// The value type for the key
    var valueType: Dictionary<String, Any>.ValueType { get }

    /// A list of all raw values associated with the key
    var rawValues: [RawValue] { get }
}
