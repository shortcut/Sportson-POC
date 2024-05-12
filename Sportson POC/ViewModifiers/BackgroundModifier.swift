//
//  BackgroundModifier.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 17. 4. 2024..
//

import SwiftUI
import ShortcutUI

struct BackgroundModifier: ViewModifier {
    var backgroundColor: Color = .mainBg

    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.size.width,
                   height: UIScreen.main.bounds.size.height - 140)
            .background(backgroundColor)
    }
}

struct ModalBackgroundModifier: ViewModifier {
    var backgroundColor: Color = .mainBg

    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.size.width,
                   height: UIScreen.main.bounds.size.height - 80)
            .background(backgroundColor)
    }
}

#Preview {
    Text("Hello world")
        .modifier(BackgroundModifier())
}
