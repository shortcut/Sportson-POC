//
//  RoundedCardModifier.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 19. 4. 2024..
//

import SwiftUI
import ShortcutUI

struct RoundedCardModifier: ViewModifier {
    var backgroundColor: Color = .white
    var borderColor: Color? = nil

    func body(content: Content) -> some View {
        content
            .mask(RoundedRectangle(cornerRadius: 12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(backgroundColor)
                    .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 3)
                    .overlay(
                        Group {
                            if let borderColor = borderColor {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(borderColor, lineWidth: 1)
                            }
                        }
                    )
            )
    }
}

#Preview {
    Text("Hello World")
        .modifier(RoundedCardModifier())
}
