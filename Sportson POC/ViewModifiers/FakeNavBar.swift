//
//  FakeNavBar.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 17. 4. 2024..
//

import SwiftUI
import ShortcutUI

struct FakeNavBarModifier: ViewModifier {
    var icon: String
    var title: String

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                navbar(icon: icon, title: title)
                Spacer()
            }
        }
    }

    @ViewBuilder
    func navbar(icon: String, title: String) -> some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(alignment: .bottom) {
                if !title.isEmpty {
                    headerText(icon: icon, text: title)
                    Spacer()
                    Image("sportson_logo_big")
                        .resizable()
                        .frame(width: 100, height: 32)
                        .padding(.trailing, 16)
                }
            }
            .padding(.bottom, 8)
            .frame(width: UIScreen.main.bounds.size.width,
                   height: 40)
            .foregroundColor(Color.spYellow)
        }
        .background(Color.darkBg)
        .frame(maxHeight: 80)
    }

    @ViewBuilder
    func headerText(icon: String, text: String) -> some View {
        HStack {
            Text(icon)
                .font(.sportson(size: 32))
            Text(text)
                .font(.emRegular(size: 16))

        }
        .padding(.leading, 16)
    }
}

#Preview {
    Text("Hello world")
        .modifier(FakeNavBarModifier(icon: "b", title: "Title"))
}
