//
//  ContentView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 15. 4. 2024..
//

import SwiftUI
import Core
import ShortcutFoundation

struct ContentView: View {
    @InjectObject var store: Store

    init() {
        UIScrollView.appearance().bounces = false
        let transparentAppearence = UITabBarAppearance()
        transparentAppearence.configureWithTransparentBackground() // 🔑
        UITabBar.appearance().standardAppearance = transparentAppearence
    }

    var body: some View {
        if store.isUserLogged || store.userDidLogin {
            TabBarView()
                .background(Color.mainBg)
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
