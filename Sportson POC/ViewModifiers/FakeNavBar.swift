//
//  FakeNavBar.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 17. 4. 2024..
//

import SwiftUI
import ShortcutUI

struct FakeNavBarModifier: ViewModifier {
    var title: String
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                navbar(title: title)
                Spacer()
            }
        }
    }

    @ViewBuilder
    func navbar(title: String) -> some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(alignment: .bottom) {
                if !title.isEmpty {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.leading, 32)
                    Spacer()
                    Text("SPORTSON")
                        .font(.callout)
                        .fontWeight(.bold)
                    Image(systemName: "bicycle")
                        .foregroundColor(.yellow)
                        .padding(.trailing, 16)
                }
            }
            .frame(width: UIScreen.main.bounds.size.width,
                   height: 40)
            .foregroundColor(.yellow)
        }
        .background(title.isEmpty ? Color.mainBg : .black)
        .frame(maxHeight: 120)
    }
}

#Preview {
    Text("Hello world")
        .modifier(FakeNavBarModifier(title: "Title"))
}
