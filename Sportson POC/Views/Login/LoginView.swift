//
//  LoginView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct LoginView: View {
    @InjectObject var store: Store

    var body: some View {
        VStack {
            Spacer()
            Image("sportson_logo_big")
            Spacer()
            Button(action:  {
                store.isUserLogged = true
                store.userDidLogin = true
            },label: {
                Text("LOGIN")
                    .frame(width: UIScreen.main.bounds.size.width * 0.7)
            })
            .font(.title2)
            .fontWeight(.semibold)
            .buttonStyle(CapsuleButtonStyle())
            .padding(.bottom, 120)
        }
        .frame(width: UIScreen.main.bounds.size.width)
    }
}

#Preview {
    LoginView()
}
