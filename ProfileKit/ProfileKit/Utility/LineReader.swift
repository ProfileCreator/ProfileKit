//
//  LineReader.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

class LineReader {

    // MARK: -
    // MARK: Private Variables Constant

    private let chunkSize: Int
    private let delimiterData: Data
    private let encoding: String.Encoding
    private let rawData: Data
    private let rawDataSize: Int

    // MARK: -
    // MARK: Private Variables

    private var atEOF: Bool
    private var buffer: Data
    private var rawDataOffset = 0

    // MARK: -
    // MARK: Initialization

    init?(data: Data, delimiter: String = "\n", encoding: String.Encoding = .utf8, chunkSize: Int = 4096) {
        guard let delimiterData = delimiter.data(using: encoding) else { return nil }

        self.atEOF = false
        self.buffer = Data(capacity: chunkSize)
        self.chunkSize = chunkSize
        self.delimiterData = delimiterData
        self.encoding = encoding
        self.rawData = data
        self.rawDataSize = data.count
    }

    // MARK: -
    // MARK: Public Functions

    func nextLine() -> String? {

        var lineData: Data?

        self.rawData.withUnsafeBytes { (u8Ptr: UnsafePointer<UInt8>) in
            let rawDataPtr = UnsafeMutableRawPointer(mutating: u8Ptr)

            // Read data chunks until a line delimiter is found
            while !self.atEOF {

                // Get the range of the string up until delimiter (if it exists)
                if let range = buffer.range(of: self.delimiterData) {

                    // Assign the data in the range to lineData
                    lineData = self.buffer.subdata(in: 0..<range.lowerBound)

                    // Remove the range from the buffer
                    buffer.removeSubrange(0..<range.upperBound)
                    return
                }

                // Verify that the offset is still within the data
                if self.rawDataOffset < self.rawDataSize {

                    // Get the next chunk size to use
                    let chunkSize = self.rawDataOffset + self.chunkSize > self.rawDataSize ? self.rawDataSize - self.rawDataOffset : self.chunkSize

                    // Get the next data chunk
                    let chunk = Data(bytesNoCopy: rawDataPtr + self.rawDataOffset, count: chunkSize, deallocator: .none)

                    // Add the chunk to the buffer
                    self.buffer.append(chunk)

                    // Update the offset
                    self.rawDataOffset += chunkSize
                } else {

                    // Offset is outide the data so set atEOF to true to exit the loop
                    self.atEOF = true

                    // If data is still in the buffer, set that as the line data
                    if !self.buffer.isEmpty {
                        lineData = self.buffer as Data

                        // Empty the buffer
                        self.buffer.count = 0
                        return
                    }
                }
            }
        }

        // If line data is not empty, convert that to string and return as the nextLine
        if let data = lineData, let line = String(data: data, encoding: self.encoding) {
            return line
        } else {
            return nil
        }
    }
}

// MARK: -
// MARK: Extension - Sequence

extension LineReader: Sequence {
    func makeIterator() -> AnyIterator<String> {
        return AnyIterator {
            self.nextLine()
        }
    }
}
