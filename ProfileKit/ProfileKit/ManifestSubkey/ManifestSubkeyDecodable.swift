//
//  ManifestSubkeyDecodable.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-06-14.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension ManifestSubkey: Decodable {
    internal func decode(from container: KeyedDecodingContainer<ManifestSubkeyKey>) throws {
        self.allowedFileTypes = try container.decodeIfPresent([String].self, forKey: .allowedFileTypes)
        self.allowCustomValue = try container.decodeIfPresent(Bool.self, forKey: .allowCustomValue) ?? false
        self.allowPastDates = try container.decodeIfPresent(Bool.self, forKey: .allowPastDates) ?? false
        self.appDeprecated = try container.decodeIfPresent(String.self, forKey: .appDeprecated)
        self.appMax = try container.decodeIfPresent(String.self, forKey: .appMax)
        self.appMin = try container.decodeIfPresent(String.self, forKey: .appMin)
        self.conditionals = try container.decodeIfPresent([[String: Any]].self, forKey: .conditionals)
        self.dateStyle = try container.decodeIfPresent(String.self, forKey: .dateStyle)
        self.defaultValue = try container.decodeIfPresent(Any.self, forKey: .defaultValue)
        self.defaultValueCopyTarget = try container.decodeIfPresent(String.self, forKey: .defaultValueCopyTarget)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptionExtended = try container.decodeIfPresent(String.self, forKey: .descriptionExtended)
        self.descriptionReference = try container.decodeIfPresent(String.self, forKey: .descriptionReference)
        self.documentationURL = try container.decodeIfPresent(String.self, forKey: .documentationURL)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled) ?? false
        self.exclude = try container.decodeIfPresent([[String: Any]].self, forKey: .exclude)
        self.excluded = try container.decodeIfPresent(Bool.self, forKey: .excluded) ?? false
        self.format = try container.decodeIfPresent(String.self, forKey: .format)
        self.hidden = try container.decodeIfPresent(ManifestSubkey.Hidden.self, forKey: .hidden) ?? .no
        self.importProcessor = try container.decodeIfPresent(String.self, forKey: .importProcessor)
        self.infoProcessor = try container.decodeIfPresent(String.self, forKey: .infoProcessor)
        self.iOSDeprecated = try container.decodeIfPresent(String.self, forKey: .iOSDeprecated)
        self.iOSMax = try container.decodeIfPresent(String.self, forKey: .iOSMax)
        self.iOSMin = try container.decodeIfPresent(String.self, forKey: .iOSMin)
        self.macOSDeprecated = try container.decodeIfPresent(String.self, forKey: .macOSDeprecated)
        self.macOSMax = try container.decodeIfPresent(String.self, forKey: .macOSMax)
        self.macOSMin = try container.decodeIfPresent(String.self, forKey: .macOSMin)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.placeholderValue = try container.decodeIfPresent(Any.self, forKey: .placeholderValue)
        self.platforms = try container.decodeIfPresent([String].self, forKey: .platforms)
        self.platformsNotSupported = try container.decodeIfPresent([String].self, forKey: .platformsNotSupported)
        self.rangeList = try container.decodeIfPresent([Any].self, forKey: .rangeList)
        self.rangeListTitles = try container.decodeIfPresent([String].self, forKey: .rangeListTitles)
        self.rangeMax = try container.decodeIfPresent(Any.self, forKey: .rangeMax)
        self.rangeMin = try container.decodeIfPresent(Any.self, forKey: .rangeMin)
        self.require = try container.decodeIfPresent(ManifestSubkey.Require.self, forKey: .require) ?? .optional
        self.required = try container.decodeIfPresent(Bool.self, forKey: .required) ?? false
        self.requireSupervision = try container.decodeIfPresent(Bool.self, forKey: .requireSupervision) ?? false
        self.requireUserApprovedMDM = try container.decodeIfPresent(Bool.self, forKey: .requireUserApprovedMDM) ?? false
        self.segments = try container.decodeIfPresent([String: [String]].self, forKey: .segments)
        self.sensitive = try container.decodeIfPresent(Bool.self, forKey: .sensitive) ?? false
        self.subkeys = try container.decodeIfPresent([ManifestSubkey].self, forKey: .subkeys) ?? [ManifestSubkey]()
        self.substitutionVariables = try container.decodeIfPresent([String: [String: String]].self, forKey: .substitutionVariables)
        self.targets = try container.decodeIfPresent([String].self, forKey: .targets)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.tvOSDeprecated = try container.decodeIfPresent(String.self, forKey: .tvOSDeprecated)
        self.tvOSMax = try container.decodeIfPresent(String.self, forKey: .tvOSMax)
        self.tvOSMin = try container.decodeIfPresent(String.self, forKey: .tvOSMin)
        self.typeInput = try container.decodeIfPresent(String.self, forKey: .typeInput)
        self.valueCopyTarget = try container.decodeIfPresent(String.self, forKey: .valueCopyTarget)
        self.valueDecimalPlaces = try container.decodeIfPresent(Int.self, forKey: .valueDecimalPlaces)
        self.valueInverted = try container.decodeIfPresent(Bool.self, forKey: .valueInverted) ?? false
        self.valueProcessor = try container.decodeIfPresent(String.self, forKey: .valueProcessor)
        self.valueUnique = try container.decodeIfPresent(Bool.self, forKey: .valueUnique) ?? false
        self.valueUnit = try container.decodeIfPresent(String.self, forKey: .valueUnit)
        self.view = try container.decodeIfPresent(String.self, forKey: .view)
    }
}
