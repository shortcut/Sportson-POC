//
//  ProfileView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct ProfileView: View {
    @InjectObject var store: Store

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 120)
                .background(Color.clear)
            listItem("Settings")
            listItem("Notifications")
            listItem("Request Service")
            listItem("About us")
            listItem("Privacy Policy")
            listItem("Terms & Conditions")
            listItem("Log out")
                .onTapGesture {
                    store.isUserLogged = false
                    store.userDidLogin = false
                }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width,
               height: UIScreen.main.bounds.size.height)
        .background(Color.mainBg)
        .modifier(FakeNavBarModifier(title: "YOUR PROFILE"))
    }

    @ViewBuilder
    func listItem(_ text: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(text)
                    .padding(.leading, 16)
                    .foregroundColor(.yellow)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 16)
                    .foregroundColor(.yellow)
            }
            .frame(height: 80)
            Rectangle().fill(.yellow)
                .frame(width: .infinity, height: 2)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ProfileView()
}
