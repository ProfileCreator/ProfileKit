//
//  ManifestSubkeyKey.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public enum ManifestSubkeyKey: String, CodingKey, CaseIterable {

    /**
     File extensions or UTIs allowed when using a file as value for a Data key.
     */
    case allowedFileTypes

    /**
     ProfileCreator: Will allow the user to either select a value from a popUp list or enter a custom value.

     Note: This key is ignored if pfm_type_inputis set.
     */
    case allowCustomValue

    /**
     ProfileCreator: If set to true this key will allow the date picker to select dates in the past.
     */
    case allowPastDates

    /**
     Version of the Application that started deprecating the key.
     */
    case appDeprecated

    /**
     Version of the Application that stopped supporting the key.
     */
    case appMax

    /**
     Version of the Application that started supporting the key.
     */
    case appMin

    /**
     Indicates the conditions for whether this key should be required.
     */
    case conditionals

    /**
     ProfileCreator: This key can be used to alter the style of the date picker.

     Supported values:
     - dateAndTime
     - time

     Defaults to dateAndTime.
     */
    case dateStyle

    /**
     The key's default value.

     Note: Must be the same type as the key's pfm_type.
     */
    case defaultValue

    /**
     KeyPath to another key which value to copy as the default for this key.
     */
    case defaultValueCopyTarget

    /**
     Description of the key.
     */
    case description

    /**
     An extended and more descriptive text used to for example clarify ambiguous behaviour or add more context.
     */
    case descriptionExtended

    /**
     The exact description string from the documentation.
     */
    case descriptionReference

    /**
     URL to additional documentation for the key.
     */
    case documentationURL

    /**
     If the key should be included in the payload content by default.
     */
    case enabled

    /**
     Indicates the conditions whether this key should be included in the payload.
     */
    case exclude

    /**
     If the key should be excluded from the exported payload.
     */
    case excluded

    /**
     A regular expression that the key value must match.
     */
    case format

    /**
     If the key or container should be hidden from the user by default.

     Supported values:
     - all
     - container
     */
    case hidden

    /**
     ProfileCreator: Name of the value import processor to use when converting an item dropped on the cellview to valid settings.

     Note: This enables drag n drop for cellviews that doesn't normally use it.

     See also: pfm_allowed_file_types
     */
    case importProcessor

    /**
     ProfileCreator: Name of the value info processor to use when displaying the information for a Data value.
     */
    case infoProcessor

    /**
     Version of iOS that started deprecating the key.
     */
    case iOSDeprecated

    /**
     Version of iOS that stopped supporting the key.
     */
    case iOSMax

    /**
     Version of iOS that started supporting the key.
     */
    case iOSMin

    /**
     Version of macOS that started deprecating the key.
     */
    case macOSDeprecated

    /**
     Version of macOS that stopped supporting the key.
     */
    case macOSMax

    /**
     Version of macOS that started supporting the key.
     */
    case macOSMin

    /**
     The name of the key.
     */
    case name

    /**
     A note to emphasize or bring something specific to the user's attention about the key.
     */
    case note

    /**
     Placeholder value for the key. Placeholder value is never included in the exported payload, it's only used to show an example value.
     */
    case placeholderValue

    /**
     Platforms that support the key.
     */
    case platforms

    /**
     Platforms that don't support the key.
     */
    case platformsNotSupported

    /**
     An array of legal values for this key.

     Note: The array must be the same type as the key's pfm_type
     */
    case rangeList

    /**
     Titles matching the values in the pfm_range_list key.

     Important: If this key is used together with pfm_range_list it must contain equal number of items.

     ProfileCreator: This key can be used to show a radio button to represent a boolean value if the following is true:

     - The key pfm_type is set to boolean
     - No pfm_range_list is set.
     - This key contains exactly 2 values.
     */
    case rangeListTitles

    /**
     The maximum value for this key.

     Note: The array must be the same type as the key's pfm_type
     */
    case rangeMax

    /**
     The minimum value for this key.

     Note: The array must be the same type as the key's pfm_type
     */
    case rangeMin

    /**
     The maximum number of items allowed in an array.
     */
    case repetitionMax

    /**
     The minimum number of items allowed in an array.
     */
    case repetitionMin

    /**
     Indicates whether this key is required to be present in the payload.

     Supported values:
     - always
     - always-nested
     - push
     */
    case require

    /**
     Indicates whether this key is required to be present in the payload.

     If set to true it's equal to pfm_require=always
     */
    case required

    /**
     Requires the device to be supervised for this key or payload to work.

     Note: Supervision is not available on macOS, see pfm_user_approved.
     */
    case requireSupervision

    /**
     Requires the device to be user approved, or enrolled using DEP for this key or payload to work.
     */
    case requireUserApprovedMDM

    /**
     ProfileCreator: This key can be used show a segmented control.

     The keys in the dictionary will be set as the segment titles.

     The value is an array of strings where each string is the KeyPath for each key to show under the selected segment.
     */
    case segments

    /**
     Indication that the value for this key might be sensitive and that a message about encrypting the profile should be shown.
     */
    case sensitive

    /**
     This key describes keys nested under the current key.
     */
    case subkeys

    /**
     Dictionary where the keys are available substitution variables and their value is a Substitution Variables Dictionary.
     */
    case substitutionVariables

    /**
     The scope where the key is valid.

     Supported values:
     - user
     - user-managed
     - system
     - system-managed.

     Default value is: user.
     */
    case targets

    /**
     The title of the key.
     */
    case title

    /**
     Version of tvOS that started deprecating the key or payload.
     */
    case tvOSDeprecated

    /**
     Version of tvOS that stopped supporting the key or payload.
     */
    case tvOSMax

    /**
     The title of the payload.
     */
    case tvOSMin

    /**
     The data type of the value for this key.
     */
    case type

    /**
     ProfileCreator: The data type of the input value for this key.

     This is used when it makes sense for the user to input another value type than the pfm_type specifies. Example.

     See also: pfm_value_processor.
     */
    case typeInput

    /**
     KeyPath to another key which value to copy as the value for this key.

     ProfileCreator: This will disable user input for this key.
     */
    case valueCopyTarget

    /**
     Number of decimal places to be used when setting and exporting a float value.

     Only available for pfm_type: float.
     */
    case valueDecimalPlaces

    /**
     Only available for pfm_type: boolean.

     Indicates that the user entered value should be inverted.

     This key is used when the pfm_title or pfm_description is worded in such a way that the value must be inverted to work as expected for the key.
     */
    case valueInverted

    /**
     ProfileCreator: Name of the value processor to use when converting a user entered value to the exported value.
     */
    case valueProcessor

    /**
     ProfileCreator: When used in a payload subkey that has pfm_type or pfm_type_input set to array, the items in the array must be unique.
     */
    case valueUnique

    /**
     Unit that the value represents. Example: milliseconds, hours, characters etc.
     */
    case valueUnit

    /**
     ProfileCreator: The view used to represent the payload key.

     These are the supported view override values:

     slider

     Note: This key is not needed for most payload keys and should not be included unless you need to change the default view.
     */
    case view
}

// MARK: -
// MARK: Extension - RawRepresentable

extension ManifestSubkeyKey: RawRepresentable {
    public typealias RawValue = String
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "pfm_allowed_file_types":              self = .allowedFileTypes
        case "pfm_date_allow_past":                 self = .allowPastDates
        case "pfm_range_list_allow_custom_value":   self = .allowCustomValue
        case "pfm_app_deprecated":                  self = .appDeprecated
        case "pfm_app_max":                         self = .appMax
        case "pfm_app_min":                         self = .appMin
        case "pfm_conditionals":                    self = .conditionals
        case "pfm_date_style":                      self = .dateStyle
        case "pfm_default":                         self = .defaultValue
        case "pfm_default_copy":                    self = .defaultValueCopyTarget
        case "pfm_description":                     self = .description
        case "pfm_description_extended":            self = .descriptionExtended
        case "pfm_description_reference":           self = .descriptionReference
        case "pfm_documentation_url":               self = .documentationURL
        case "pfm_enabled":                         self = .enabled
        case "pfm_exclude":                         self = .exclude
        case "pfm_excluded":                        self = .excluded
        case "pfm_format":                          self = .format
        case "pfm_hidden":                          self = .hidden
        case "pfm_value_import_processor":          self = .importProcessor
        case "pfm_value_info_processor":            self = .infoProcessor
        case "pfm_ios_deprecated":                  self = .iOSDeprecated
        case "pfm_ios_max":                         self = .iOSMax
        case "pfm_ios_min":                         self = .iOSMin
        case "pfm_macos_deprecated":                self = .macOSDeprecated
        case "pfm_macos_max":                       self = .macOSMax
        case "pfm_macos_min":                       self = .macOSMin
        case "pfm_name":                            self = .name
        case "pfm_note":                            self = .note
        case "pfm_value_placeholder":               self = .placeholderValue
        case "pfm_platforms":                       self = .platforms
        case "pfm_n_platforms":                     self = .platformsNotSupported
        case "pfm_repetition_max":                  self = .repetitionMax
        case "pfm_repetition_min":                  self = .repetitionMin
        case "pfm_require":                         self = .require
        case "pfm_required":                        self = .required
        case "pfm_supervised":                      self = .requireSupervision
        case "pfm_user_approved":                   self = .requireUserApprovedMDM
        case "pfm_range_list":                      self = .rangeList
        case "pfm_range_list_titles":               self = .rangeListTitles
        case "pfm_range_max":                       self = .rangeMax
        case "pfm_range_min":                       self = .rangeMin
        case "pfm_segments":                        self = .segments
        case "pfm_sensitive":                       self = .sensitive
        case "pfm_subkeys":                         self = .subkeys
        case "pfm_substitution_variables":          self = .substitutionVariables
        case "pfm_targets":                         self = .targets
        case "pfm_title":                           self = .title
        case "pfm_tvos_deprecated":                 self = .tvOSDeprecated
        case "pfm_tvos_max":                        self = .tvOSMax
        case "pfm_tvos_min":                        self = .tvOSMin
        case "pfm_type":                            self = .type
        case "pfm_type_input":                      self = .typeInput
        case "pfm_value_copy":                      self = .valueCopyTarget
        case "pfm_value_decimal_places":            self = .valueDecimalPlaces
        case "pfm_value_inverted":                  self = .valueInverted
        case "pfm_value_processor":                 self = .valueProcessor
        case "pfm_value_unique":                    self = .valueUnique
        case "pfm_value_unit":                      self = .valueUnit
        case "pfm_view":                            self = .view

        default:                            return nil
        }
    }
}

// MARK: -
// MARK: Extension - rawValue

public extension ManifestSubkeyKey {
    var rawValue: RawValue {
        switch self {
        case .allowedFileTypes:         return "pfm_allowed_file_types"
        case .allowPastDates:           return "pfm_date_allow_past"
        case .allowCustomValue:         return "pfm_range_list_allow_custom_value"
        case .appDeprecated:            return "pfm_app_deprecated"
        case .appMax:                   return "pfm_app_max"
        case .appMin:                   return "pfm_app_min"
        case .conditionals:             return "pfm_conditionals"
        case .dateStyle:                return "pfm_date_style"
        case .defaultValue:             return "pfm_default"
        case .defaultValueCopyTarget:   return "pfm_default_copy"
        case .description:              return "pfm_description"
        case .descriptionExtended:      return "pfm_description_extended"
        case .descriptionReference:     return "pfm_description_reference"
        case .documentationURL:         return "pfm_documentation_url"
        case .enabled:                  return "pfm_enabled"
        case .exclude:                  return "pfm_exclude"
        case .excluded:                 return "pfm_excluded"
        case .format:                   return "pfm_format"
        case .hidden:                   return "pfm_hidden"
        case .importProcessor:          return "pfm_value_import_processor"
        case .infoProcessor:            return "pfm_value_info_processor"
        case .iOSDeprecated:            return "pfm_ios_deprecated"
        case .iOSMax:                   return "pfm_ios_max"
        case .iOSMin:                   return "pfm_ios_min"
        case .macOSDeprecated:          return "pfm_macos_deprecated"
        case .macOSMax:                 return "pfm_macos_max"
        case .macOSMin:                 return "pfm_macos_min"
        case .name:                     return "pfm_name"
        case .note:                     return "pfm_note"
        case .placeholderValue:         return "pfm_value_placeholder"
        case .platforms:                return "pfm_platforms"
        case .platformsNotSupported:    return "pfm_n_platforms"
        case .repetitionMax:            return "pfm_repetition_max"
        case .repetitionMin:            return "pfm_repetition_min"
        case .require:                  return "pfm_require"
        case .required:                 return "pfm_required"
        case .requireSupervision:       return "pfm_supervised"
        case .requireUserApprovedMDM:   return "pfm_user_approved"
        case .rangeList:                return "pfm_range_list"
        case .rangeListTitles:          return "pfm_range_list_titles"
        case .rangeMax:                 return "pfm_range_max"
        case .rangeMin:                 return "pfm_range_min"
        case .segments:                 return "pfm_segments"
        case .sensitive:                return "pfm_sensitive"
        case .subkeys:                  return "pfm_subkeys"
        case .substitutionVariables:    return "pfm_substitution_variables"
        case .targets:                  return "pfm_targets"
        case .title:                    return "pfm_title"
        case .tvOSDeprecated:           return "pfm_tvos_deprecated"
        case .tvOSMax:                  return "pfm_tvos_max"
        case .tvOSMin:                  return "pfm_tvos_min"
        case .type:                     return "pfm_type"
        case .typeInput:                return "pfm_type_input"
        case .valueCopyTarget:          return "pfm_value_copy"
        case .valueDecimalPlaces:       return "pfm_value_decimal_places"
        case .valueInverted:            return "pfm_value_inverted"
        case .valueProcessor:           return "pfm_value_processor"
        case .valueUnique:              return "pfm_value_unique"
        case .valueUnit:                return "pfm_value_unit"
        case .view:                     return "pfm_view"
        }
    }
}

// MARK: -
// MARK: Extension - ProfileKeyProtocol

extension ManifestSubkeyKey: ProfileKeyProtocol {
    public var valueType: Dictionary<String, Any>.ValueType {
        switch self {
        case .allowedFileTypes:         return .array   // OF strings
        case .allowPastDates:           return .bool
        case .allowCustomValue:         return .bool
        case .appDeprecated:            return .string
        case .appMax:                   return .string
        case .appMin:                   return .string
        case .conditionals:             return .array   // OF dictionaries
        case .dateStyle:                return .string
        case .defaultValue:             return .any
        case .defaultValueCopyTarget:   return .string
        case .description:              return .string
        case .descriptionExtended:      return .string
        case .descriptionReference:     return .string
        case .documentationURL:         return .string
        case .enabled:                  return .bool
        case .exclude:                  return .array   // OF dictionaries
        case .excluded:                 return .bool
        case .format:                   return .string
        case .hidden:                   return .string
        case .importProcessor:          return .string
        case .infoProcessor:            return .string
        case .iOSDeprecated:            return .string
        case .iOSMax:                   return .string
        case .iOSMin:                   return .string
        case .macOSDeprecated:          return .string
        case .macOSMax:                 return .string
        case .macOSMin:                 return .string
        case .name:                     return .string
        case .note:                     return .string
        case .placeholderValue:         return .any
        case .platforms:                return .array   // OF strings
        case .platformsNotSupported:    return .array   // OF strings
        case .repetitionMax:            return .integer
        case .repetitionMin:            return .integer
        case .require:                  return .string
        case .required:                 return .bool
        case .requireSupervision:       return .bool
        case .requireUserApprovedMDM:   return .bool
        case .rangeList:                return .array   // OF any
        case .rangeListTitles:          return .array   // OF strings
        case .rangeMax:                 return .integer // AND float
        case .rangeMin:                 return .integer // AND float
        case .segments:                 return .dictionary
        case .sensitive:                return .bool
        case .subkeys:                  return .array   // OF dictionaries
        case .substitutionVariables:    return .dictionary
        case .targets:                  return .array   // OF strings
        case .title:                    return .string
        case .tvOSDeprecated:           return .string
        case .tvOSMax:                  return .string
        case .tvOSMin:                  return .string
        case .type:                     return .string
        case .typeInput:                return .string
        case .valueCopyTarget:          return .string
        case .valueDecimalPlaces:       return .integer
        case .valueInverted:            return .bool
        case .valueProcessor:           return .string
        case .valueUnique:              return .bool
        case .valueUnit:                return .string
        case .view:                     return .string
        }
    }

    public var rawValues: [RawValue] {
        switch self {

        // All that doesn't have multiple values, just return rawValue
        default:                        return [self.rawValue]
        }
    }
}
