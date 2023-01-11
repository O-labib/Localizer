//
//  Utils.swift
//  
//
//  Created by Omar Labib on 11/01/2023.
//

import Foundation

enum Utils {
    static var projectDirectory: String? {
        CommandLine.arguments.count <= 1 ? nil : CommandLine.arguments[1]
    }

    static var localizableFiles: [String] {
        guard
            let rootDir = Utils.projectDirectory,
            let files = FileManager.default.enumerator(atPath: rootDir)?.allObjects.compactMap({ $0 as? String })
        else {
            return []
        }

        return files.filter({$0.hasSuffix("/Localizable.strings") })
    }
    
    static func contentOf(file relativeFilePath: String) -> FileContent {
        guard let rootDir = projectDirectory else { return [] }

        let filePath = "file:///\(rootDir)/\(relativeFilePath)"
        guard
            let url = URL(string: filePath),
            let fileContent = try? String(contentsOf: url, encoding: .utf8)
        else {
            return []
        }

        return fileContent.trimmingCharacters(in: .newlines).components(separatedBy: "\n")
    }

    static func write(content: String, to relativeFilePath: String) -> Bool {
        guard let rootDir = projectDirectory else { return false }

        let filePath = "file:///\(rootDir)/\(relativeFilePath)"

        guard
            let url = URL(string: filePath)
        else {
            return false
        }
        do {
            try content.write(to: url, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
}

typealias FileContent = [String]

extension FileContent {
    func contains(key: String) -> Bool {
        contains(where: { $0.contains(key.quoted) })
    }
}
