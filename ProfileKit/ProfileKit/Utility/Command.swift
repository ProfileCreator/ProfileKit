//
//  Command.swift
//  Profiles
//
//  Created by Erik Berglund.
//  Copyright © 2019 Erik Berglund. All rights reserved.
//

import Foundation

public class Command {
    public static func run(path: String, arguments: [String]?) throws -> Data {
        let task = Process()
        let stdOutPipe = Pipe()

        task.launchPath = path
        task.arguments = arguments
        task.standardOutput = stdOutPipe

        if #available(OSX 10.13, *) {
            try task.run()
        } else {
            task.launch()
        }

        return stdOutPipe.fileHandleForReading.readDataToEndOfFile()
    }

    public static func plistFromOutputStringData(_ data: Data) throws -> [String: Any]? {
        guard let string = String(data: data, encoding: .utf8) else {
            Swift.print("Failed to get string from command output")
            return nil
        }

        let plistScanner = Scanner(string: string)
        var plistScannerString: NSString? = ""

        // Move to the first line containing '<?xml'
        plistScanner.scanUpTo("<?xml", into: nil)

        // Get the string contents between the first '<?xml' and '</plist>' encountered
        if !plistScanner.scanUpTo("</plist>", into: &plistScannerString) {
            return nil
        }

        // If the scannerString is not empty, replace the plistString
        guard let plistString = plistScannerString as String?, let plistData = (plistString + "\n</plist>").data(using: .utf8) else {
            return nil
        }

        // Convert the output to a dictionary
        guard let plist = try PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: Any] else {
            Swift.print("Failed to decode plist string \(plistString))")
            return nil
        }

        return plist
    }
}
