//
//  Color+Extensions.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 17. 4. 2024..
//

import SwiftUI

extension Color {
    static let mainBg = Color(hex: "#F7F7F7")
    static let darkBg = Color(hex: "#1B1B1B")
    static let spYellow = Color(hex: "#FFCC01")
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0

        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
