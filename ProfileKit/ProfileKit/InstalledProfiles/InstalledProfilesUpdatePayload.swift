//
//  InstalledProfiles.swift
//  ProfileKit
//
//  Created by Erik Berglund on 2019-05-02.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

extension InstalledProfiles {

    /// Function to add some of the missing payload info that is hinted at in the InternalData structure
    internal static func updatePayloadContent(in profile: [String: Any]) -> [String: Any] {
        guard let internalData = profile[InstalledProfileKey.internalData.rawValue] as? [String: Any] else {
            return profile
        }

        var updatedProfile = profile

        // Check if there are any PersistentCertificateRefs in the payload
        if let persistentCertificateRef = internalData[InstalledProfileKey.persistentCertificateRef.rawValue] as? [[String: Any]] {
            updatedProfile = self.updatePayload(inProfile: updatedProfile, withPersistentCertificateRef: persistentCertificateRef)
        }

        return updatedProfile
    }

    // MARK: -
    // MARK: PersistentCertificateRef

    /// Function to add the actual certificates referenced in PersistentCertificateRef
    private static func updatePayload(inProfile profile: [String: Any], withPersistentCertificateRef certRef: [[String: Any]]) -> [String: Any] {
        var updatedProfile = profile

        guard var updatedPayloadContent = profile[InstalledProfileKey.payloadContent.rawValue] as? [[String: Any]] else {
            return updatedProfile
        }

        for certRefDict in certRef {
            guard let uuid = certRefDict[InstalledProfileKey.payloadUUID.rawValue] as? String else {

                // FIXME: Proper Logging
                Swift.print("Found no \(InstalledProfileKey.payloadUUID.rawValue) key in profile: \(profile)")
                continue
            }

            // Get the index for a profile with the same uuid
            guard let index = updatedPayloadContent.firstIndex(where: { $0[InstalledProfileKey.payloadUUID.rawValue] as? String == uuid }) else {

                // FIXME: Proper Logging
                Swift.print("Found no payload with PayloadUUID: \(uuid)")
                continue
            }

            // Get the payload with the matching UUID
            var payload = updatedPayloadContent[index]

            let certData: Data

            // Get a PKCS1 Certificate
            if let certRefData = (certRefDict[InstalledProfileKey.certificate.rawValue] as? [Data])?.first {
                guard let resolvedCertData = KeychainQuery.certificateData(forPersistentRef: certRefData) else {

                    // FIXME: Proper Logging
                    Swift.print("Failed to get certificate from certRefData: \(certRefData)")
                    continue
                }
                certData = resolvedCertData

                // Get a PKCS12 Identity Certificate
            } else if certRefDict[InstalledProfileKey.identityCertificate.rawValue] != nil || certRefDict[InstalledProfileKey.identityPrivateKey.rawValue] != nil {
                guard let resolvedCertData = KeychainQuery.identity(forPersistentRefDict: certRefDict) else {

                    // FIXME: Proper Logging
                    Swift.print("Failed to get identity certificate from certRefDict: \(certRefDict)")
                    continue
                }
                certData = resolvedCertData
            } else {

                // FIXME: Proper Logging
                Swift.print("Unknown content in \(InstalledProfileKey.persistentCertificateRef.rawValue) dict: \(certRefDict)")
                continue
            }

            // Set the returned certificate as the PayloadContent for the payload
            payload[InstalledProfileKey.payloadContent.rawValue] = certData

            // Set the updated payload to the payload content
            updatedPayloadContent[index] = payload
        }

        updatedProfile[InstalledProfileKey.payloadContent.rawValue] = updatedPayloadContent

        return updatedProfile
    }
}
