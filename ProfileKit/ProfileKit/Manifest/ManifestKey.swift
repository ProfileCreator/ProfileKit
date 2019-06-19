//
//  ManifestKey.swift
//  ProfileKit
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public enum ManifestKey: String, CodingKey, CaseIterable {

    /**
     URL to the Application homepage.
     */
    case appURL

    /**
     Description of the payload.
     */
    case description

    /**
     The exact description string from the documentation.
     */
    case descriptionReference

    /**
     URL to additional documentation for the payload.
     */
    case documentationURL

    /**
     The application domain for this preference manifest file
     */
    case domain

    /**
     The domain identifier for this preference manifest file
     */
    case domainIdentifier

    /**
     The preference manifest format version.
     */
    case formatVersion

    /**
     Bsse64 encoded data of an image resource that is 64x64 pixels.
     */
    case icon

    /**
     How payload settings will interact when multiple payloads of the same type are installed on a device.

     Supported values:
     - combined
     - exclusive
     - undefined
     */
    case interaction

    /**
     Version of iOS that started deprecating the payload.
     */
    case iOSDeprecated

    /**
     Version of iOS that stopped supporting the payload.
     */
    case iOSMax

    /**
     Version of iOS that started supporting the payload.
     */
    case iOSMin

    /**
     Date the manifest was last modified.
     */
    case lastModified

    /**
     Version of macOS that started deprecating the payload.
     */
    case macOSDeprecated

    /**
     Version of macOS that stopped supporting the payload.
     */
    case macOSMax

    /**
     Version of macOS that started supporting the payload.
     */
    case macOSMin

    /**
     A note to emphasize or bring something specific to the user's attention about the payload.
     */
    case note

    /**
     Platforms that support the payload.
     */
    case platforms

    /**
     Requires the device to be supervised for this payload to work.
     
     Note: Supervision is not available on macOS, see pfm_user_approved.
     */
    case requireSupervision

    /**
     Requires the device to be user approved, or enrolled using DEP for this payload to work.
     */
    case requireUserApprovedMDM

    /**
     Identifier used to allow a payload domain (pfm_domain) to be split in multiple files.

     If this is not set, multiple files with the same domain will be read as duplicates and overwrite each other.

     Useful for domains that have multiple uses like com.apple.MCX and .GlobalPreferences.
     */
    case subdomain

    /**
     This key describes keys nested under the current key.
     */
    case subkeys

    /**
     Dictionary where the keys are available substitution variables and their value is a Substitution Variables Dictionary.
     */
    case substitutionVariables

    /**
     The scope where the payload is valid.

     Supported values:
     - user
     - user-managed
     - system
     - system-managed.

     Default value is: user.
     */
    case targets

    /**
     The title of the payload.
     */
    case title

    /**
     Version of tvOS that started deprecating the payload.
     */
    case tvOSDeprecated

    /**
     Version of tvOS that stopped supporting the payload.
     */
    case tvOSMax

    /**
     The title of the payload.
     */
    case tvOSMin

    /**
     Indicates if multiple payloads of this type can be installed on a device.
     */
    case unique

    /**
     Version of the manifest file.
     */
    case version
}

// MARK: -
// MARK: Extension - RawRepresentable

extension ManifestKey: RawRepresentable {
    public typealias RawValue = String
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "pfm_app_url":                 self = .appURL
        case "pfm_description":             self = .description
        case "pfm_description_reference":   self = .descriptionReference
        case "pfm_documentation_url":       self = .documentationURL
        case "pfm_domain":                  self = .domain
        case "pfm_format_version":          self = .formatVersion
        case "pfm_icon":                    self = .icon
        case "pfm_interaction":             self = .interaction
        case "pfm_ios_deprecated":          self = .iOSDeprecated
        case "pfm_ios_max":                 self = .iOSMax
        case "pfm_ios_min":                 self = .iOSMin
        case "pfm_last_modified":           self = .lastModified
        case "pfm_macos_deprecated":        self = .macOSDeprecated
        case "pfm_macos_max":               self = .macOSMax
        case "pfm_macos_min":               self = .macOSMin
        case "pfm_note":                    self = .note
        case "pfm_platforms":               self = .platforms
        case "pfm_supervised":              self = .requireSupervision
        case "pfm_user_approved":           self = .requireUserApprovedMDM
        case "pfm_subdomain":               self = .subdomain
        case "pfm_subkeys":                 self = .subkeys
        case "pfm_substitution_variables":  self = .substitutionVariables
        case "pfm_targets":                 self = .targets
        case "pfm_title":                   self = .title
        case "pfm_tvos_deprecated":         self = .tvOSDeprecated
        case "pfm_tvos_max":                self = .tvOSMax
        case "pfm_tvos_min":                self = .tvOSMin
        case "pfm_unique":                  self = .unique
        case "pfm_version":                 self = .version

        // Values for keys not in the manifest format
        case "pfm_domain_identifier":       self = .domainIdentifier

        default:                            return nil
        }
    }
}

// MARK: -
// MARK: Extension - rawValue

public extension ManifestKey {
    var rawValue: RawValue {
        switch self {
        case .appURL:                   return "pfm_app_url"
        case .description:              return "pfm_description"
        case .descriptionReference:     return "pfm_description_reference"
        case .documentationURL:         return "pfm_documentation_url"
        case .domain:                   return "pfm_domain"
        case .formatVersion:            return "pfm_format_version"
        case .icon:                     return "pfm_icon"
        case .interaction:              return "pfm_interaction"
        case .iOSDeprecated:            return "pfm_ios_deprecated"
        case .iOSMax:                   return "pfm_ios_max"
        case .iOSMin:                   return "pfm_ios_min"
        case .lastModified:             return "pfm_last_modified"
        case .macOSDeprecated:          return "pfm_macos_deprecated"
        case .macOSMax:                 return "pfm_macos_max"
        case .macOSMin:                 return "pfm_macos_min"
        case .note:                     return "pfm_note"
        case .platforms:                return "pfm_platforms"
        case .requireSupervision:       return "pfm_supervised"
        case .requireUserApprovedMDM:   return "pfm_user_approved"
        case .subdomain:                return "pfm_subdomain"
        case .subkeys:                  return "pfm_subkeys"
        case .substitutionVariables:    return "pfm_substitution_variables"
        case .targets:                  return "pfm_targets"
        case .title:                    return "pfm_title"
        case .tvOSDeprecated:           return "pfm_tvos_deprecated"
        case .tvOSMax:                  return "pfm_tvos_max"
        case .tvOSMin:                  return "pfm_tvos_min"
        case .unique:                   return "pfm_unique"
        case .version:                  return "pfm_version"

        // Values for keys not in the manifest format
        case .domainIdentifier:         return "pfm_domain_identifier"
        }
    }
}

// MARK: -
// MARK: Extension - ProfileKeyProtocol

extension ManifestKey: ProfileKeyProtocol {
    public var valueType: Dictionary<String, Any>.ValueType {
        switch self {
        case .appURL:                   return .string
        case .description:              return .string
        case .descriptionReference:     return .string
        case .documentationURL:         return .string
        case .domain:                   return .string
        case .formatVersion:            return .integer
        case .icon:                     return .data
        case .interaction:              return .string
        case .iOSDeprecated:            return .string
        case .iOSMax:                   return .string
        case .iOSMin:                   return .string
        case .lastModified:             return .date
        case .macOSDeprecated:          return .string
        case .macOSMax:                 return .string
        case .macOSMin:                 return .string
        case .note:                     return .string
        case .platforms:                return .array
        case .requireSupervision:       return .bool
        case .requireUserApprovedMDM:   return .bool
        case .subdomain:                return .string
        case .subkeys:                  return .array
        case .substitutionVariables:    return .dictionary
        case .targets:                  return .array
        case .title:                    return .string
        case .tvOSDeprecated:           return .string
        case .tvOSMax:                  return .string
        case .tvOSMin:                  return .string
        case .unique:                   return .bool
        case .version:                  return .integer

        // Values for keys not in the manifest format
        case .domainIdentifier:         return .string
        }
    }

    public var rawValues: [RawValue] {
        switch self {

        // All that doesn't have multiple values, just return rawValue
        default:                        return [self.rawValue]
        }
    }
}
