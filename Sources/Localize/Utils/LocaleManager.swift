//
//  LocaleManager.swift
//  
//
//  Created by Omar Labib on 11/01/2023.
//

import Foundation

enum LocaleManager {
    static func tryRemovingKey() {
        print("What key do you want to remove?".inYellow)
        guard
            let key = readLine(), !key.isEmpty else {
            print("Invalid Key".inRed)
                return
            }

        for relativeFilePath in Utils.localizableFiles {
            var fileContent = Utils.contentOf(file: relativeFilePath)
            guard fileContent.contains(key: key) else {
                print("Key \(key) not found at \(relativeFilePath)".inRed)
                continue
            }
            fileContent.removeAll(where: { $0.contains(key.quoted) })

            let updatedFileContent = fileContent.joined(separator: "\n")
            let successfulWrite = Utils.write(content: updatedFileContent, to: relativeFilePath)
            if successfulWrite {
                print("Successfully deleted Key \(key) at \(relativeFilePath)".inGreen)
            }
        }
    }

    static func tryAddingKey() {
        print("What key do you want to add?".inYellow)
        guard
            let key = readLine(), !key.isEmpty else {
            print("Invalid Key".inRed)
                return
            }
        var filesWithValues: [String: String] = [:]

        for relativeFilePath in Utils.localizableFiles {
            print("Enter value for \(relativeFilePath)".inYellow)

            guard
                let value = readLine(), !value.isEmpty else {
                print("Invalid Value".inRed)
                return
            }
            filesWithValues[relativeFilePath] = value
        }

        for (relativeFilePath, value) in filesWithValues {
            var fileContent = Utils.contentOf(file: relativeFilePath)
            guard !fileContent.contains(key: key) else {
                print("Key \(key) already has value at \(relativeFilePath)".inRed)
                continue
            }
            let newKeyValue = "\(key.quoted) = \(value.quoted);"
            fileContent.append(newKeyValue)

            let updatedFileContent = fileContent.joined(separator: "\n")
            let successfulWrite = Utils.write(content: updatedFileContent, to: relativeFilePath)
            if successfulWrite {
                print("Successfully added Key \(key) at \(relativeFilePath)".inGreen)
            }
        }
    }

    static func tryModifyingKey() {
        print("What key do you want to Modify it's value?".inYellow)
        guard
            let key = readLine(), !key.isEmpty else {
            print("Invalid Key".inRed)
                return
            }
        var filesWithValues: [String: String] = [:]

        for relativeFilePath in Utils.localizableFiles {
            print("Enter value for \(relativeFilePath)".inYellow)

            guard
                let value = readLine(), !value.isEmpty else {
                print("Invalid Value".inRed)
                continue
            }
            filesWithValues[relativeFilePath] = value
        }

        for (relativeFilePath, value) in filesWithValues {
            var fileContent = Utils.contentOf(file: relativeFilePath)
            guard fileContent.contains(key: key) else {
                print("Key \(key) doesn't have value at \(relativeFilePath)".inRed)
                continue
            }

            let index = fileContent.firstIndex(where: { $0.contains(key.quoted) })

            let newKeyValue = "\(key.quoted) = \(value.quoted);"
            if let index {
                fileContent[index] = newKeyValue
            } else {
                fileContent.append(newKeyValue)
            }

            let updatedFileContent = fileContent.joined(separator: "\n")
            let successfulWrite = Utils.write(content: updatedFileContent, to: relativeFilePath)
            if successfulWrite {
                print("Successfully Modified value for Key \(key) at \(relativeFilePath)".inGreen)
            }
        }
    }
}

