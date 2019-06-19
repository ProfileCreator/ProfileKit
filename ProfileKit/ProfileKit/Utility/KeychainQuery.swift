//
//  KeychainQuery.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-05-02.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

internal struct KeychainQuery {

    /// Return the first keychain item matching the persistentRef
    private static func keychainItem(withPersistentRef persistentRef: Data) -> AnyObject? {
        let query = [ kSecValuePersistentRef as String: persistentRef,
                      kSecReturnAttributes as String: kCFBooleanTrue!,
                      kSecMatchLimit as String: kSecMatchLimitOne,
                      kSecReturnRef as String: kCFBooleanTrue!] as [String: Any]

        var queryResult: AnyObject?
        var osStatus: OSStatus = errSecSuccess

        osStatus = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        guard osStatus == errSecSuccess else {
            let osStatusString = String(SecCopyErrorMessageString(osStatus, nil) ?? "")
            Swift.print("Error when getting keychain item from ref: \(osStatusString)")
            return nil
        }

        guard let resultDict = queryResult as? [String: AnyObject] else {
            Swift.print("Error when getting query result items for code signing identity from ref")
            return nil
        }

        return resultDict[kSecValueRef as String]
    }

    /// Return the first certificate matching the persistentRef
    static func certificate(forPersistentRef persistentRef: Data) -> SecCertificate? {
        guard let value = self.keychainItem(withPersistentRef: persistentRef)  else {
            Swift.print("Failed to get keychain item for persistent ref: \(persistentRef)")
            return nil
        }

        guard CFGetTypeID(value) == SecCertificateGetTypeID() else {
            Swift.print("Value returned for query was of an unknown type: \(CFGetTypeID(value))")
            return nil
        }

        // swiftlint:disable:next force_cast
        return (value as! SecCertificate)
    }

    /// Return the first certificate matching the persistentRef as Data
    static func certificateData(forPersistentRef persistentRef: Data) -> Data? {
        guard let certificate = self.certificate(forPersistentRef: persistentRef) else { return nil }
        return SecCertificateCopyData(certificate) as Data
    }

    /// Return the first identity matching the persistentRef
    static func identity(forPersistentRefDict persistentRefDict: [String: Any]) -> Data? {
        guard
            let identityCertificateRef = persistentRefDict[InstalledProfileKey.identityCertificate.rawValue] as? Data,
            let identityCert = self.certificate(forPersistentRef: identityCertificateRef) else {
                return nil
        }

        var secIdentity: SecIdentity?
        var osStatus: OSStatus = errSecSuccess

        osStatus = withUnsafeMutablePointer(to: &secIdentity) {
            SecIdentityCreateWithCertificate(nil, identityCert, $0)
        }

        guard osStatus == errSecSuccess else {
            let osStatusString = String(SecCopyErrorMessageString(osStatus, nil) ?? "")
            Swift.print("Error when creating SecIdentity with certificate: \(osStatusString)")
            return nil
        }

        guard let identity = secIdentity else {
            Swift.print("Error when getting created identity")
            return nil
        }

        var identityCFData: CFData?
        var identityParameters = SecItemImportExportKeyParameters(version: UInt32(SEC_KEY_IMPORT_EXPORT_PARAMS_VERSION),
                                                                  flags: SecKeyImportExportFlags(),
                                                                  passphrase: Unmanaged<CFTypeRef>.passRetained("" as CFTypeRef),
                                                                  alertTitle: nil,
                                                                  alertPrompt: nil,
                                                                  accessRef: nil,
                                                                  keyUsage: nil,
                                                                  keyAttributes: nil)

        osStatus = withUnsafeMutablePointer(to: &identityCFData) {
            SecItemExport(identity, .formatPKCS12, SecItemImportExportFlags(), &identityParameters, $0)
        }

        guard osStatus == errSecSuccess else {
            let osStatusString = String(SecCopyErrorMessageString(osStatus, nil) ?? "")
            Swift.print("Error when exporting SecIdentity to data: \(osStatusString)")
            return nil
        }

        return identityCFData as Data?
    }
}
