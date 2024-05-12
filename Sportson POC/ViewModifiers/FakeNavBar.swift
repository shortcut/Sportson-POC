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
    var action: (() -> ())? = nil
    let navBarHeight: CGFloat = 80

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: navBarHeight)
                content
            }
            navbar(icon: icon, title: title, action: action)
        }
    }

    @ViewBuilder
    func navbar(icon: String, title: String, action: (() -> ())? = nil) -> some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(alignment: .bottom) {
                if !title.isEmpty {
                    if let action {
                        backButton {
                            action()
                        }
                    } else {
                        headerText(icon: icon, text: title)
                    }
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
        .frame(height: navBarHeight)
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

    @ViewBuilder
    func backButton(_ action: @escaping ()->()) -> some View {
        Button(action: action, label: {
            HStack {
                Image(systemName: "chevron.left")
            }
            Text("Tillbaka")
                .font(.emRegular(size: 16))
        })
        .padding(.leading, 16)
    }
}

#Preview {
    Text("Hello world")
        .modifier(FakeNavBarModifier(icon: "b", title: "Title"))
}
