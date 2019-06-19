//
//  ProfileSigner.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public enum ProfileSignerError: Error {
    case isEncrypted
    case cannotGetDecryptedData
    case osStatus(code: OSStatus, message: String?)
}

public struct ProfileSigner {

    // MARK: -
    // MARK: Private Static Functions

    private static func executeCMSFunction(_ cmsFunction: () -> OSStatus) throws {
        let osStatus = cmsFunction()
        guard osStatus == errSecSuccess else {
            throw ProfileSignerError.osStatus(code: osStatus, message: SecCopyErrorMessageString(osStatus, nil) as String?)
        }
    }

    // MARK: -
    // MARK: Public Static Functions

    public static func sign(profileData: Data, withIdentity identity: SecIdentity) throws -> Data {
        let data = [UInt8](profileData)

        // Create an encoder and add the profileData
        var encoder: CMSEncoder!
        try executeCMSFunction { CMSEncoderCreate(&encoder) }
        try executeCMSFunction { CMSEncoderUpdateContent(encoder, data, data.count) }

        // Add identity and attributes
        try executeCMSFunction { CMSEncoderAddSigners(encoder, identity) }
        try executeCMSFunction { CMSEncoderAddSignedAttributes(encoder, .attrSmimeCapabilities) }

        // Copy the encoded data
        var signedCFData: CFData?
        try executeCMSFunction { CMSEncoderCopyEncodedContent(encoder, &signedCFData) }

        // Cast the returnd CFData to a swift Data type
        guard let signedData = signedCFData as Data? else {
            throw ProfileSignerError.cannotGetDecryptedData
        }

        return signedData
    }

    public static func unsign(profileData: Data) throws -> Data {

        // Create a decoder for the profileData
        let decoder = try self.decoder(forData: profileData)

        // Verify the profile data is not encrypted
        guard try !self.isEncrypted(decoder) else {
            throw ProfileSignerError.isEncrypted
        }

        // Verify the profile is signed
        guard try self.isSigned(decoder) else {
            return profileData
        }

        // Copy the unsigned profile data
        var unsignedCFData: CFData?
        try executeCMSFunction { CMSDecoderCopyContent(decoder, &unsignedCFData) }

        // Cast the returnd CFData to a swift Data type
        guard let unsignedData = unsignedCFData as Data? else {
            throw ProfileSignerError.cannotGetDecryptedData
        }

        return unsignedData
    }
}

// MARK: -
// MARK: Decoder Functions

extension ProfileSigner {
    private static func decoder(forData: Data) throws -> CMSDecoder {
        let data = [UInt8](forData)

        // Create a decoder and add data
        var decoder: CMSDecoder!
        try executeCMSFunction { CMSDecoderCreate(&decoder) }
        try executeCMSFunction { CMSDecoderUpdateMessage(decoder, data, data.count) }
        try executeCMSFunction { CMSDecoderFinalizeMessage(decoder) }
        return decoder
    }

    private static func isEncrypted(_ decoder: CMSDecoder) throws -> Bool {
        var isEncrypted: DarwinBoolean = false
        try executeCMSFunction { CMSDecoderIsContentEncrypted(decoder, &isEncrypted) }
        return isEncrypted.boolValue
    }

    private static func isSigned(_ decoder: CMSDecoder) throws -> Bool {
        var numSigners: Int!
        try executeCMSFunction { CMSDecoderGetNumSigners(decoder, &numSigners) }
        return 0 < numSigners
    }
}
