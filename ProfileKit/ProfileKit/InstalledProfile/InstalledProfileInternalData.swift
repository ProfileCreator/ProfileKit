//
//  InstalledProfileInternalData.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

class InstalledProfileInternalData {

    // MARK: -
    // MARK: Variables Static

    // MARK: -
    // MARK: Variables Required

    // From /usr/libexec/mdmclient
    var fileModDate: Date
    var installSource: String

    // MARK: -
    // MARK: Variables Optional

    // From /usr/libexec/mdmclient
    var installedByUID: Int?
    var payloadScope: String?
    var syntheticInputDetected: Bool?
    var cmsCertificatesInfo: String?

    // From /usr/bin/profiles
    var installDate: Date?
    var verificationState: String?

    required init(from decoder: Decoder) throws {

        // Get the decoder container
        let container = try decoder.container(keyedBy: InstalledProfileKey.self)

        // Decode Required Values
        self.fileModDate = try container.decodeStringDate(forKey: .fileModDate)
        self.installSource = try container.decode(String.self, forKey: .installSource)

        // Decode Optional Values
        try self.decode(from: container)
    }
}

// MARK: -
// MARK: Extension - Decodable

extension InstalledProfileInternalData: Decodable {
    func decode(from container: KeyedDecodingContainer<InstalledProfileKey>) throws {
        self.installedByUID = try container.decodeIfPresent(Int.self, forKey: .installedByUID)
        self.payloadScope = try container.decodeIfPresent(String.self, forKey: .payloadScope)
        self.syntheticInputDetected = try container.decodeIfPresent(Bool.self, forKey: .syntheticInputDetected)
    }
}

// MARK: -
// MARK: Extension - Encodable

extension InstalledProfileInternalData: Encodable {
    func encode(to encoder: Encoder) throws {

        // Get the encoding container
        var container = encoder.container(keyedBy: InstalledProfileKey.self)

        // Encode Required Values
        try container.encode(self.fileModDate, forKey: .fileModDate)
        try container.encode(self.installSource, forKey: .installSource)

        // Encode Optional Values
        try container.encodeIfPresent(self.installedByUID, forKey: .installedByUID)
        try container.encodeIfPresent(self.payloadScope, forKey: .payloadScope)
        try container.encodeIfPresent(self.syntheticInputDetected, forKey: .syntheticInputDetected)
    }
}
