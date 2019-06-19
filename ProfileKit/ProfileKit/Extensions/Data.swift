//
//  Data.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension Data {

    // Modified version from https://stackoverflow.com/a/26503955
    init(withHexString hexString: String) {
        self.init()
        var hex = hexString
        while !hex.isEmpty {
            let subIndex = hex.index(hex.startIndex, offsetBy: 2)
            let c = String(hex[..<subIndex])
            hex = String(hex[subIndex...])
            var ch: UInt32 = 0
            Scanner(string: c).scanHexInt32(&ch)
            var char = UInt8(ch)
            self.append(&char, count: 1)
        }
    }

    func plist() throws -> [String: Any] {
        var format = PropertyListSerialization.PropertyListFormat.xml
        return try withUnsafeMutablePointer(to: &format) {
            guard let plist = try PropertyListSerialization.propertyList(from: self, options: .mutableContainersAndLeaves, format: $0) as? [String: Any] else {
                // FIXME: Add correct Error
                throw NSError(domain: "example.domain", code: 3, userInfo: nil)
            }
            return plist
        }
    }
}
