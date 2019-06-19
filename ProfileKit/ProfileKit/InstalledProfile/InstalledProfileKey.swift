//
//  InstalledProfileKey.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

// swiftlint:disable file_length

import Foundation

public enum InstalledProfileKey: String, CodingKey, CaseIterable {

    /**
     Optional. Number of seconds until the profile is automatically removed.

     If the RemovalDate keys is present, whichever field yields the earliest date will be used.
     */
    case durationUntilRemoval

    /**
     Optional. Array of payload dictionaries. Not present if IsEncrypted is true.
     */
    case payloadContent

    /**
     Optional. A description of the profile, shown on the Detail screen for the profile.

     This should be descriptive enough to help the user decide whether to install the profile.
     */
    case payloadDescription

    /**
     Optional. A human-readable name for the profile.

     This value is displayed on the Detail screen. It does not have to be unique.
     */
    case payloadDisplayName

    /**
     Optional. A date on which a profile is considered to have expired and can be updated over the air.

     This key is only used if the profile is delivered via over-the-air profile delivery.
     */
    case payloadExpirationDate

    /**
     A reverse-DNS style identifier (com.example.myprofile, for example) that identifies the profile.

     This string is used to determine whether a new profile should replace an existing one or should be added.
     */
    case payloadIdentifier

    /**
     Optional. A human-readable string containing the name of the organization that provided the profile.
     */
    case payloadOrganization

    /**
     A globally unique identifier for the profile.

     The actual content is unimportant, but it must be globally unique. In macOS, you can use uuidgen to generate reasonable UUIDs.
     */
    case payloadUUID

    /**
     Optional. Supervised only. If present and set to true, the user cannot delete the profile (unless the profile has a removal password and the user provides it).
     */
    case payloadRemovalDisallowed

    /**
     The only supported value is Configuration.
     */
    case payloadType

    /**
     The version number of the profile format.

     This describes the version of the configuration profile as a whole, not of the individual profiles within it.
     Currently, this value should be 1.
     */
    case payloadVersion

    /**
     Optional. Determines if the profile should be installed for the system or the user.

     In many cases, it determines the location of the certificate items, such as keychains. Though it is not possible to declare different payload scopes, payloads, like VPN, may automatically install their items in both scopes if needed.

     Legal values are System and User, with User as the default value.

     - Requires: Available in macOS 10.7 and later.
     */
    case payloadScope

    /**
     Optional. The date on which the profile will be automatically removed.
     */
    case removalDate

    /**
     Optional. A dictionary containing these keys and values:
     • Foreachlanguageinwhichaconsentorlicense
     agreement is available, a key consisting of the IETF BCP 47 identifier for that language (for example, en or jp) and a value consisting of the agreement localized to that language. The agreement is displayed in a dialog to which the user must agree before installing the profile.
     • Theoptionalkeydefaultwithitsvalueconsistingofthe unlocalized agreement (usually in en).
     The system chooses a localized version in the order of preference specified by the user (macOS) or based on the userʼs current language setting (iOS). If no exact match is found, the default localization is used. If there is no default localization, the en localization is used. If there is no en localization, then the first available localization is used.
     You should provide a default value if possible. No warning will be displayed if the userʼs locale does not match any localization in the ConsentText dictionary.
     */
    case consentText

    // MARK: -
    // MARK: Internal Data
    // MARK: -

    // FIXME: Add Description for AllowPairing
    /**
     -

     From /usr/libexec/mdmclient
     */
    case allowPairing

    // FIXME: Add Description for AnchorCertificates
    /**
     -

     From /usr/libexec/mdmclient
     */
    case anchorCertificates

    // FIXME: Add Description for AwaitDeviceConfigured
    /**
     -

     From /usr/libexec/mdmclient
     */
    case awaitDeviceConfigured

    // FIXME: Add Description for Certificate, CertData
    /**
     -

     From /usr/libexec/mdmclient
     */
    case certificate

    // FIXME: Add Description for CloudConfigProfile
    /**
     -

     From /usr/libexec/mdmclient
     */
    case cloudConfigProfile

    // FIXME: Add Description for CloudConfiguration_UserGUID
    /**
     -

     From /usr/libexec/mdmclient
     */
    case cloudConfigurationUserGUID

    // FIXME: Add Description for CloudConfiguration_Info
    /**
     -

     From /usr/libexec/mdmclient
     */
    case cloudConfigurationInfo

    // FIXME: Add Description for CMSCertificatesInfo
    /**
     -

     From /usr/libexec/mdmclient
     */
    case cmsCertificatesInfo

    // FIXME: Add Description for ConfigurationURL
    /**
     -

     From /usr/libexec/mdmclient
     */
    case configurationURL

    /**
     Date the installed profile's mobileconfig was last modified.

     From /usr/libexec/mdmclient
     */
    case fileModDate

    // FIXME: Add Description for IdentityCertificate
    /**
     -

     From /usr/libexec/mdmclient
     */
    case identityCertificate

    // FIXME: Add Description for IdentityPrivateKey
    /**
     -

     From /usr/libexec/mdmclient
     */
    case identityPrivateKey

    /**
     Date the profile was installed.

     From /usr/bin/profiles
     */
    case installDate

    // FIXME: Add Description for InstallSource
    /**
     -

     From /usr/libexec/mdmclient
     */
    case installSource

    /**
     UID of the user that the profile is installed for.

     From /usr/bin/profiles (Not a key but generated from the top level key user names).
     */
    case installedForUID

    /**
     -

     From /usr/bin/profiles (Not a key but copied from the top level key user names).
     */
    case installedForUser

    /**
     UID of the user that installed the profile.

     From /usr/libexec/mdmclient
     */
    case installedByUID

    // FIXME: Add Description for InternalData
    /**
     -

     From /usr/libexec/mdmclient
     */
    case internalData

    // FIXME: Add Description for IsMandatory
    /**
     -

     From /usr/libexec/mdmclient
     */
    case isMandatory

    // FIXME: Add Description for IsMDMUnremovable
    /**
     -

     From /usr/libexec/mdmclient
     */
    case isMDMUnremovable

    // FIXME: Add Description for IsSignerCert
    /**
     -

     From /usr/libexec/mdmclient
     */
    case isSignerCert

    // FIXME: Add Description for IsSupervised
    /**
     -

     From /usr/libexec/mdmclient
     */
    case isSupervised

    // FIXME: Add Description for ManagedSource
    /**
     -

     From /usr/libexec/mdmclient
     */
    case managedSource

    // FIXME: Add Description for MDM_InstalledByUser
    /**
     -

     From /usr/libexec/mdmclient
     */
    case mdmInstalledByUser

    // FIXME: Add Description for MDM_OnlyManagingDevice
    /**
     -

     From /usr/libexec/mdmclient
     */
    case mdmOnlyManagingDevice

    // FIXME: Add Description for MDM_OrganizationInfo
    /**
     -

     From /usr/libexec/mdmclient
     */
    case mdmOrganizationInfo

    // FIXME: Add Description for MDM_PayloadIdentifier
    /**
     -

     From /usr/libexec/mdmclient
     */
    case mdmPayloadIdentifier

    // FIXME: Add Description for MDM_ProfileIdentifier
    /**
     -

     From /usr/libexec/mdmclient
     */
    case mdmProfileIdentifier

    // FIXME: Add Description for MDM_PushMagic
    /**
     -

     From /usr/libexec/mdmclient
     */
    case mdmPushMagic

    // FIXME: Add Description for MDM_ServerURL
    /**
     -

     From /usr/libexec/mdmclient
     */
    case mdmServerURL

    // FIXME: Add Description for OrganizationAddress
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationAddress

    // FIXME: Add Description for OrganizationAddressLine1
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationAddressLine1

    // FIXME: Add Description for OrganizationAddressLine2
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationAddressLine2

    // FIXME: Add Description for OrganizationCity
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationCity

    // FIXME: Add Description for OrganizationCountry
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationCountry

    // FIXME: Add Description for OrganizationDepartment
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationDepartment

    // FIXME: Add Description for OrganizationEmail
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationEmail

    // FIXME: Add Description for OrganizationMagic
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationMagic

    // FIXME: Add Description for OrganizationName
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationName

    // FIXME: Add Description for OrganizationPhone
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationPhone

    // FIXME: Add Description for OrganizationSupportPhone
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationSupportPhone

    // FIXME: Add Description for OrganizationZipCode
    /**
     -

     From /usr/libexec/mdmclient
     */
    case organizationZipCode

    // FIXME: Add Description for PersistentCertificateRef
    /**
     -

     From /usr/libexec/mdmclient
     */
    case persistentCertificateRef

    // FIXME: Add Description for SkipSetup
    /**
     -

     From /usr/libexec/mdmclient
     */
    case skipSetup

    // FIXME: Add Description for SyntheticInputDetected
    /**
     -

     From /usr/libexec/mdmclient
     */
    case syntheticInputDetected

    // FIXME: Add Description for ProfileVerificationState
    /**
     -

     From /usr/bin/profiles
     */
    case verificationState

    // FIXME: Add Description for WasEncrypted
    /**
     -

     From /usr/libexec/mdmclient
     */
    case wasEncrypted

    // Not Seen Yet
    /*
     case durationUntilRemoval       // DurationUntilRemoval
     case hidden                     // Hidden
     case installedPayloadUUIDs      // _installedPayloadUUIDs
     case installPending             // _installPending
     case installFailed              // _installFailed
     case lastAutoCertRenewal        // LastAutoCertRenewal
     case manuallyApproved           // ManuallyApproved
     case mdmServerType              // MDM_ServerType
     case odAttributeUUID            // OD_AttributeUUID
     case odRecordNode               // OD_RecordNode
     case odRecordType               // OD_RecordType
     case orphanedKeychainItems      // OrphanedKeychainItems
     case otaConfirmInstall          // OTA_ConfirmInstall
     case otaDeviceAttrsToQuery      // OTA_DeviceAttrsToQuery
     case otaIdentityExport          // OTA_IdentityExport
     case otaProfileIdentifier       // OTA_ProfileIdentifier
     case otaProfileUUID             // OTA_ProfileUUID
     case otaServerURL               // OTA_ServerURL
     case payloadExpirationDate      // PayloadExpirationDate
     case pendingUserGUID            // _pendingUserGUID
     case persistentSystemCertificateRef  // PersistentSystemCertificateRef
     case profileAccounts            // ProfileAccounts
     case removalDate                // RemovalDate
     case systemPolicies             // SystemPolicies
     */
}

// MARK: -
// MARK: Extension - RawRepresentable

extension InstalledProfileKey: RawRepresentable {
    public typealias RawValue = String
    public init?(rawValue: RawValue) {
        switch rawValue.trimmingCharacters(in: CharacterSet(charactersIn: "\"")) {
        case "ConsentText":                 self = .consentText
        case "DurationUntilRemoval":        self = .durationUntilRemoval
        case "InternalData",
             "Internal data":               self = .internalData
        case "PayloadContent",
             "ProfileItems":                self = .payloadContent
        case "PayloadDescription",
             "ProfileDescription":          self = .payloadDescription
        case "PayloadDisplayName",
             "ProfileDisplayName",
             "Profile Name",
             "Name":                        self = .payloadDisplayName
        case "PayloadExpirationDate":       self = .payloadExpirationDate
        case "PayloadIdentifier",
             "ProfileIdentifier",
             "Identifier":                  self = .payloadIdentifier
        case "PayloadOrganization",
             "ProfileOrganization":         self = .payloadOrganization
        case "PayloadRemovalDisallowed",
             "ProfileRemovalDisallowed",
             "RemovalDisallowed":           self = .payloadRemovalDisallowed
        case "PayloadScope":                self = .payloadScope
        case "PayloadType",
             "ProfileType",
             "Type":                        self = .payloadType
        case "PayloadUUID",
             "ProfileUUID",
             "UUID":                        self = .payloadUUID
        case "PayloadVersion",
             "ProfileVersion":              self = .payloadVersion
        case "RemovalDate":                 self = .removalDate

        // Internal Data

        case "AllowPairing":                self = .allowPairing
        case "AnchorCertificates":          self = .anchorCertificates
        case "AwaitDeviceConfigured":       self = .awaitDeviceConfigured
        case "Certificate", "CertData":     self = .certificate
        case "CloudConfigProfile":          self = .cloudConfigProfile
        case "CloudConfiguration_Info":     self = .cloudConfigurationInfo
        case "CloudConfiguration_UserGUID": self = .cloudConfigurationUserGUID
        case "CMSCertificatesInfo":         self = .cmsCertificatesInfo
        case "ConfigurationURL":            self = .configurationURL
        case "FileModDate":                 self = .fileModDate
        case "IdentityCertificate":         self = .identityCertificate
        case "IdentityPrivateKey":          self = .identityPrivateKey
        case "ProfileInstallDate",
             "InstallDate":                 self = .installDate
        case "InstallSource":               self = .installSource
        case "InstalledForUID":             self = .installedForUID
        case "InstalledForUser":            self = .installedForUser
        case "InstalledByUID":              self = .installedByUID
        case "IsMandatory":                 self = .isMandatory
        case "IsMDMUnremovable":            self = .isMDMUnremovable
        case "IsSignerCert":                self = .isSignerCert
        case "IsSupervised":                self = .isSupervised
        case "ManagedSource":               self = .managedSource
        case "MDM_InstalledByUser":         self = .mdmInstalledByUser
        case "MDM_OnlyManagingDevice":      self = .mdmOnlyManagingDevice
        case "MDM_OrganizationInfo":        self = .mdmOrganizationInfo
        case "MDM_PayloadIdentifier":       self = .mdmPayloadIdentifier
        case "MDM_ProfileIdentifier":       self = .mdmProfileIdentifier
        case "MDM_PushMagic":               self = .mdmPushMagic
        case "MDM_ServerURL":               self = .mdmServerURL
        case "OrganizationAddress":         self = .organizationAddress
        case "OrganizationAddressLine1":    self = .organizationAddressLine1
        case "OrganizationAddressLine2":    self = .organizationAddressLine1
        case "OrganizationCity":            self = .organizationCity
        case "OrganizationCountry":         self = .organizationCountry
        case "OrganizationDepartment":      self = .organizationDepartment
        case "OrganizationEmail":           self = .organizationEmail
        case "OrganizationMagic":           self = .organizationMagic
        case "OrganizationName":            self = .organizationName
        case "OrganizationPhone":           self = .organizationPhone
        case "OrganizationSupportPhone":    self = .organizationSupportPhone
        case "OrganizationZipCode":         self = .organizationZipCode
        case "PersistentCertificateRef":    self = .persistentCertificateRef
        case "SkipSetup":                   self = .skipSetup
        case "SyntheticInputDetected":      self = .syntheticInputDetected
        case "ProfileVerificationState",
             "VerificationState":           self = .verificationState
        case "WasEncrypted":                self = .mdmServerURL
        default:
            return nil
        }
    }
}

// MARK: -
// MARK: Extension - rawValue

public extension InstalledProfileKey {
    var rawValue: RawValue {
        switch self {
        case .allowPairing:                 return "AllowPairing"
        case .consentText:                  return "ConsentText"
        case .durationUntilRemoval:         return "DurationUntilRemoval"
        case .internalData:                 return "InternalData"
        case .payloadContent:               return "PayloadContent"
        case .payloadDescription:           return "PayloadDescription"
        case .payloadDisplayName:           return "PayloadDisplayName"
        case .payloadExpirationDate:        return "PayloadExpirationDate"
        case .payloadIdentifier:            return "PayloadIdentifier"
        case .payloadOrganization:          return "PayloadOrganization"
        case .payloadRemovalDisallowed:     return "PayloadRemovalDisallowed"
        case .payloadScope:                 return "PayloadScope"
        case .payloadType:                  return "PayloadType"
        case .payloadUUID:                  return "PayloadUUID"
        case .payloadVersion:               return "PayloadVersion"
        case .removalDate:                  return "RemovalDate"

        // Internal Data

        case .anchorCertificates:           return "AnchorCertificates"
        case .awaitDeviceConfigured:        return "AwaitDeviceConfigured"
        case .certificate:                  return "Certificate"
        case .cloudConfigProfile:           return "CloudConfigProfile"
        case .cloudConfigurationInfo:       return "CloudConfiguration_Info"
        case .cloudConfigurationUserGUID:   return "CloudConfiguration_UserGUID"
        case .cmsCertificatesInfo:          return "CMSCertificatesInfo"
        case .configurationURL:             return "ConfigurationURL"
        case .fileModDate:                  return "FileModDate"
        case .identityCertificate:          return "IdentityCertificate"
        case .identityPrivateKey:           return "IdentityPrivateKey"
        case .installDate:                  return "InstallDate"
        case .installSource:                return "InstallSource"
        case .installedForUID:              return "InstalledForUID"
        case .installedForUser:             return "InstalledForUser"
        case .installedByUID:               return "InstalledByUID"
        case .isMandatory:                  return "IsMandatory"
        case .isMDMUnremovable:             return "IsMDMUnremovable"
        case .isSignerCert:                 return "IsSignerCert"
        case .isSupervised:                 return "IsSupervised"
        case .managedSource:                return "ManagedSource"
        case .mdmInstalledByUser:           return "MDM_InstalledByUser"
        case .mdmOnlyManagingDevice:        return "MDM_OnlyManagingDevice"
        case .mdmOrganizationInfo:          return "MDM_OrganizationInfo"
        case .mdmPayloadIdentifier:         return "MDM_PayloadIdentifier"
        case .mdmProfileIdentifier:         return "MDM_ProfileIdentifier"
        case .mdmPushMagic:                 return "MDM_PushMagic"
        case .mdmServerURL:                 return "MDM_ServerURL"
        case .organizationAddress:          return "OrganizationAddress"
        case .organizationAddressLine1:     return "OrganizationAddressLine1"
        case .organizationAddressLine2:     return "OrganizationAddressLine2"
        case .organizationCity:             return "OrganizationCity"
        case .organizationCountry:          return "OrganizationCountry"
        case .organizationDepartment:       return "OrganizationDepartment"
        case .organizationEmail:            return "OrganizationEmail"
        case .organizationMagic:            return "OrganizationMagic"
        case .organizationName:             return "OrganizationName"
        case .organizationPhone:            return "OrganizationPhone"
        case .organizationSupportPhone:     return "OrganizationSupportPhone"
        case .organizationZipCode:          return "OrganizationZipCode"
        case .persistentCertificateRef:     return "PersistentCertificateRef"
        case .skipSetup:                    return "SkipSetup"
        case .syntheticInputDetected:       return "SyntheticInputDetected"
        case .verificationState:            return "VerificationState"
        case .wasEncrypted:                 return "WasEncrypted"
        }
    }
}

// MARK: -
// MARK: Extension - ProfileKeyProtocol

extension InstalledProfileKey: ProfileKeyProtocol {
    public var valueType: Dictionary<String, Any>.ValueType {
        switch self {
        case .consentText:                  return .string
        case .durationUntilRemoval:         return .integer
        case .internalData:                 return .dictionary
        case .payloadContent:               return .dictionary
        case .payloadDescription:           return .string
        case .payloadDisplayName:           return .string
        case .payloadExpirationDate:        return .date
        case .payloadIdentifier:            return .string
        case .payloadOrganization:          return .string
        case .payloadRemovalDisallowed:     return .bool
        case .payloadScope:                 return .string
        case .payloadType:                  return .string
        case .payloadUUID:                  return .string
        case .payloadVersion:               return .integer
        case .removalDate:                  return .date

        // Internal Data

        case .allowPairing:                 return .bool
        case .anchorCertificates:           return .array
        case .awaitDeviceConfigured:        return .bool
        case .certificate:                  return .data
        case .cloudConfigProfile:           return .dictionary
        case .cloudConfigurationInfo:       return .dictionary
        case .cloudConfigurationUserGUID:   return .string
        case .cmsCertificatesInfo:          return .dictionary
        case .configurationURL:             return .string
        case .identityCertificate:          return .data
        case .identityPrivateKey:           return .data
        case .fileModDate:              	return .date
        case .installDate:              	return .date
        case .installSource:            	return .string
        case .installedForUID:              return .string
        case .installedForUser:             return .string
        case .installedByUID:           	return .integer
        case .isMandatory:              	return .bool
        case .isMDMUnremovable:             return .bool
        case .isSignerCert:             	return .bool
        case .isSupervised:                 return .bool
        case .managedSource:                return .string
        case .mdmInstalledByUser:           return .string
        case .mdmOnlyManagingDevice:        return .integer
        case .mdmOrganizationInfo:          return .dictionary
        case .mdmPayloadIdentifier:         return .string
        case .mdmProfileIdentifier:         return .string
        case .mdmPushMagic:                 return .string
        case .mdmServerURL:                 return .string
        case .organizationAddress:          return .string
        case .organizationAddressLine1:     return .string
        case .organizationAddressLine2:     return .string
        case .organizationCity:             return .string
        case .organizationCountry:          return .string
        case .organizationDepartment:       return .string
        case .organizationEmail:            return .string
        case .organizationMagic:            return .string
        case .organizationName:             return .string
        case .organizationPhone:            return .string
        case .organizationSupportPhone:     return .string
        case .organizationZipCode:          return .string
        case .persistentCertificateRef:     return .array
        case .skipSetup:                    return .array
        case .syntheticInputDetected:       return .integer
        case .verificationState:            return .string
        case .wasEncrypted:                 return .bool
        }
    }

    public var rawValues: [RawValue] {
        switch self {
        case .internalData:             return [self.rawValue, "Internal data"]
        case .payloadContent:           return [self.rawValue, "ProfileItems"]
        case .payloadDescription:       return [self.rawValue, "ProfileDescription"]
        case .payloadDisplayName:       return [self.rawValue, "ProfileDisplayName", "Profile Name", "Name"]
        case .payloadIdentifier:        return [self.rawValue, "ProfileIdentifier", "Identifier"]
        case .payloadOrganization:      return [self.rawValue, "ProfileOrganization"]
        case .payloadRemovalDisallowed: return [self.rawValue, "ProfileRemovalDisallowed", "RemovalDisallowed"]
        case .payloadType:              return [self.rawValue, "ProfileType", "Type"]
        case .payloadUUID:              return [self.rawValue, "ProfileUUID", "UUID"]
        case .payloadVersion:           return [self.rawValue, "ProfileVersion"]

        // Internal Data
        case .certificate:              return [self.rawValue, "CertData"]
        case .installDate:              return [self.rawValue, "ProfileInstallDate"]
        case .verificationState:        return [self.rawValue, "ProfileVerificationState"]

        // All that doesn't have multiple values, just return rawValue
        default:                        return [self.rawValue]
        }
    }
}
