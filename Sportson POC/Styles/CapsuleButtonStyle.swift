//
//  CapsuleButtonStyle.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 17. 4. 2024..
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.yellow)
            .foregroundStyle(.black)
            .clipShape(Capsule())
    }
}
