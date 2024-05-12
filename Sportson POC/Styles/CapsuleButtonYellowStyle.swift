//
//  CapsuleButtonStyle.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 17. 4. 2024..
//

import SwiftUI

struct CapsuleButtonYellowStyle: ButtonStyle {
    var enabled = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(enabled ? Color.spYellow: Color.gray)
            .foregroundStyle(.black)
            .clipShape(Capsule())
    }
}

struct CapsuleButtonClearStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.clear)
            .foregroundStyle(.gray)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(.gray, lineWidth: 1))
    }
}
