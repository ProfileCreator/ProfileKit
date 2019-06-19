//
//  InstalledProfile.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class InstalledProfile: Profile {

    // MARK: -
    // MARK: Variables Static

    // MARK: -
    // MARK: Variables Required

    var internalData: InstalledProfileInternalData

    // MARK: -
    // MARK: Variables Optional

    // MARK: -
    // MARK: Initialization

    required init(from decoder: Decoder) throws {

        // Get the decoder container
        let container = try decoder.container(keyedBy: InstalledProfileKey.self)

        // Decode Required Values
        self.internalData = try container.decode(InstalledProfileInternalData.self, forKey: .internalData)

        // Initialize the superclass
        try super.init(from: decoder)
    }
}
