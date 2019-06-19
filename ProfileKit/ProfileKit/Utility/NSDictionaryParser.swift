//
//  NSDictionaryParser.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public struct NSDictionaryParser {
    static func array<T: RawRepresentable & ProfileKeyProtocol>(forLogRepresentation lines: [String],
                                                                withKeyType keyType: T.Type,
                                                                kvSeparator: String.Element = ":") -> [Any]? where T.RawValue == String {

        guard
            let firstLine = lines.first?.trimmingCharacters(in: .whitespacesAndNewlines),
            let lastLine = lines.last else {
                return nil
        }

        var array = [Any]()
        var index = 0

        // Variables for collection content (i.e. if the array content type is a collection)
        var collectionContent = false
        var collectionIndent = ""
        var collectionStartChar = ""
        var collectionEndChar = ""
        if ["{", "("].contains(firstLine) {
            collectionContent = true
            collectionStartChar = firstLine
            collectionEndChar = firstLine == "{" ? "}" : ")"
            collectionIndent = self.indentWhitespace(forLine: lastLine) + "    "
        }

        while index < (lines.endIndex - 1) {
            let line = lines[index]
            var lineTrimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)

            if lineTrimmed == collectionStartChar {

                // Get the next line
                let nextIndex = index + 1
                guard nextIndex < lines.endIndex else {
                    return nil
                }

                // Get the last index for the current collection
                let lastIndex = lines[nextIndex...].firstIndex(where: { $0.hasPrefix(collectionIndent + collectionEndChar) }) ?? (lines.endIndex - 1)

                // Check if this line starts a collection
                switch lineTrimmed {
                case "{":
                    // Extract an array slice for the dictionary and parse it separately
                    if let subDict = self.dictionary(forLogRepresentation: Array(lines[nextIndex...lastIndex]), withKeyType: keyType, kvSeparator: "=") {
                        array.append(subDict)
                    } else {
                        Swift.print("Failed to parse dictionary in array")
                    }
                case "(":
                    // Extract an array slice for the array and parse it separately
                    if let subArray = self.array(forLogRepresentation: Array(lines[nextIndex...lastIndex]), withKeyType: keyType, kvSeparator: "=") {
                        array.append(subArray)
                    } else {
                        Swift.print("Failed to parse array in array")
                    }

                default:
                    return nil
                }

                // Continue the loop to after the collection
                index = lastIndex
                continue
            } else if !collectionContent {

                // Remove trailing semicolon for sub-dictionaries
                if kvSeparator == "=" {
                    lineTrimmed = lineTrimmed.deletingSuffix(";")
                }

                // Remove extra quotes for strings with non alphanumeric characters
                if lineTrimmed.hasPrefix("\""), lineTrimmed.hasSuffix("\"") {
                    lineTrimmed = lineTrimmed.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                }

                // Remove trailing comma for single value array values
                lineTrimmed = lineTrimmed.deletingSuffix(",")

                array.append(ProfileKit.valueAttemtingToGuessType(lineTrimmed))
            }

            index += 1
        }

        return array
    }

    static func dictionary<T: RawRepresentable & ProfileKeyProtocol>(forLogRepresentation lines: [String],
                                                                     withKeyType keyType: T.Type,
                                                                     kvSeparator: String.Element = ":") -> [String: Any]? where T.RawValue == String {

        var dict = [String: Any]()
        var index = 0

        while index < lines.endIndex {
            let line = lines[index]
            // Swift.print("dictionary line: \(index): \(line)")

            // Split the line in two using the passed kvSeparator
            let lineArray: [Substring]
            lineArray = line.split(separator: kvSeparator, maxSplits: 1, omittingEmptySubsequences: true)

            // If we got two strings, continue to add the key value to the dict
            if 2 <= lineArray.count {

                // Get the key/value as strings without leading whitespaces and newlines
                let key = String(lineArray[0].trimmingCharacters(in: .whitespacesAndNewlines))
                var value = String(lineArray[1].trimmingCharacters(in: .whitespacesAndNewlines))

                // Get the keyEnum if the key matches
                let keyEnum = keyType.init(rawValue: key)
                let keyString = keyEnum?.rawValue ?? key.trimmingCharacters(in: CharacterSet(charactersIn: "\""))

                // Log any key that's not available in the key enym
                if keyEnum == nil { Swift.print("No case in \(keyType.self) for: \(keyString)") }

                // Check if this is a dictionary or an array
                if ["{", "("].contains(value) {
                    let endChar = value == "{" ? "}" : ")"

                    // Get the next line
                    let nextIndex = index + 1
                    guard nextIndex < lines.endIndex else {
                        break
                    }

                    // Get the current line's indent
                    let lineIndent = self.indentWhitespace(forLine: line)

                    // Get the last index for the current collection
                    let lastIndex = lines[nextIndex...].firstIndex(where: { $0.hasPrefix(lineIndent + endChar + ";") }) ?? (lines.endIndex - 1)

                    switch value {
                    case "{":
                        // Extract an array slice for the dictionary and parse it separately
                        if let subDict = self.dictionary(forLogRepresentation: Array(lines[nextIndex...lastIndex]), withKeyType: keyType, kvSeparator: "=") {
                            dict[keyString] = subDict
                        } else {
                            Swift.print("Failed to parse dictionary for key: \(keyString)")
                        }
                    case "(":
                        // Extract an array slice for the array and parse it separately
                        if let subArray = self.array(forLogRepresentation: Array(lines[nextIndex...lastIndex]), withKeyType: keyType, kvSeparator: "=") {
                            dict[keyString] = subArray
                        } else {
                            Swift.print("Failed to parse array for key: \(keyString)")
                        }

                    default:
                        return nil
                    }

                    // Continue the loop to after the collection
                    index = lastIndex
                    continue
                }

                // Remove trailing semicolon for sub-dictionaries
                if kvSeparator == "=" {
                    value = value.deletingSuffix(";")
                }

                // Remove extra quotes for strings with non alphanumeric characters
                if value.hasPrefix("\""), value.hasSuffix("\"") {
                    value = value.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                }

                dict[keyString] = ProfileKit.value(value, attemptingToCastAsTypeForKey: keyEnum)
            }

            index += 1
        }

        return dict
    }
}

// MARK: -
// MARK: Private Static Functions

extension NSDictionaryParser {

    /// Return the leading whitespace for line
    private static func indentWhitespace(forLine line: String) -> String {
        let range = line.range(of: "^\\s+", options: .regularExpression)
        return range == nil ? "" : String(line[..<range!.upperBound])
    }
}
