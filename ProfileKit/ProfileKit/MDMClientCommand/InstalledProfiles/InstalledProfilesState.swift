//
//  StateInstalledProfiles.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public struct InstalledProfilesState {
    public var scope: Scope = .system
    public var level: Level = .profile
    public var flags: Flags = []

    public mutating func setScope(_ scope: Scope) {
        self.scope = scope
        self.level = .profile
        self.flags = []
    }
}

public enum Scope: String {
    case system = "System"
    case user = "User"
}

public enum Level {
    case none
    case profile
    case payload
}

public struct Flags: OptionSet {
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public let rawValue: Int
    public static let internalData = Flags(rawValue: 1 << 0 )
    public static let cmsInfo = Flags(rawValue: 1 << 1 )
}
