//
//  ManifestSubkey.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class ManifestSubkey {

    // MARK: -
    // MARK: Variables Static

    // MARK: -
    // MARK: Variables Required

    public var name: String
    public var type: String

    // MARK: -
    // MARK: Variables Optional

    public var allowedFileTypes: [String]?
    public var allowCustomValue: Bool = false
    public var allowPastDates: Bool = false
    public var appDeprecated: String?
    public var appMax: String?
    public var appMin: String?
    public var conditionals: [[String: Any]]?
    public var dateStyle: String?
    public var defaultValue: Any?
    public var defaultValueCopyTarget: String?
    public var description: String?
    public var descriptionExtended: String?
    public var descriptionReference: String?
    public var documentationURL: String?
    public var enabled: Bool = false
    public var exclude: [[String: Any]]?
    public var excluded: Bool = false
    public var format: String?
    public var hidden: ManifestSubkey.Hidden = .no
    public var importProcessor: String?
    public var infoProcessor: String?
    public var iOSDeprecated: String?
    public var iOSMax: String?
    public var iOSMin: String?
    public var macOSDeprecated: String?
    public var macOSMax: String?
    public var macOSMin: String?
    public var note: String?
    public var placeholderValue: Any?
    public var platforms: [String]?
    public var platformsNotSupported: [String]?
    public var rangeList: [Any]?
    public var rangeListTitles: [String]?
    public var rangeMax: Any?
    public var rangeMin: Any?
    public var require: ManifestSubkey.Require = .optional
    public var required: Bool = false
    public var requireSupervision: Bool = false
    public var requireUserApprovedMDM: Bool = false
    public var segments: [String: [String]]?
    public var sensitive: Bool = false
    public var subkeys = [ManifestSubkey]()
    public var substitutionVariables: [String: [String: String]]?
    public var targets: [String]?
    public var title: String?
    public var tvOSDeprecated: String?
    public var tvOSMax: String?
    public var tvOSMin: String?
    public var typeInput: String?
    public var valueCopyTarget: String?
    public var valueDecimalPlaces: Int?
    public var valueInverted: Bool = false
    public var valueProcessor: String?
    public var valueUnique: Bool = false
    public var valueUnit: String?
    public var view: String?

    // MARK: -
    // MARK: Variables Externally set/Generated

    public var subkeyParent: ManifestSubkey?
    public var isSinglePayloadContent: Bool = false

    // MARK: -
    // MARK: Initialization

    public required init(from decoder: Decoder) throws {

        // Get the decoder container
        let container = try decoder.container(keyedBy: ManifestSubkeyKey.self)

        // Decode Required Values
        self.type = try container.decode(String.self, forKey: .type)
        if let name = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        } else {
            // FIXME: This needs to check if the parent is an array
            self.name = self.type + "Item"
        }

        // Decode Optional Values
        try self.decode(from: container)
    }
}

extension CodingUserInfoKey {
    static let manifestSubkeyParent = CodingUserInfoKey(rawValue: "ManifestSubkeyParent")!
    static let manifestSubkeyParentKeyPath = CodingUserInfoKey(rawValue: "ManifestSubkeyParentKeyPath")!
}
