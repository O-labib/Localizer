//
//  String+Extensions.swift
//  
//
//  Created by Omar Labib on 11/01/2023.
//

import Foundation

extension String {
    var quoted: String {
        "\"\(self)\""
    }

    var inRed: String {
        "\u{001B}[0;31m \(self) \u{001B}[0;0m"
    }

    var inYellow: String {
        "\u{001B}[0;33m \(self) \u{001B}[0;0m"
    }

    var inGreen: String {
        "\u{001B}[0;32m \(self) \u{001B}[0;0m"
    }
}
