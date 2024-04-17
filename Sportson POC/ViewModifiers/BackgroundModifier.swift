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
                   height: UIScreen.main.bounds.size.height)
            .background(backgroundColor.edgesIgnoringSafeArea(.all))
            .ignoresSafeArea(.all)
    }
}

#Preview {
    Text("Hello world")
        .modifier(BackgroundModifier())
}
