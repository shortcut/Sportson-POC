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
    var body: some View {
        TabBarView()
            .background(Color.mainBg.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
}
