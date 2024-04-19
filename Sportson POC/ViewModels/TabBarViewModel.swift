//
//  TabBarViewModel.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import Foundation
import SwiftUI
import ShortcutFoundation
import Core

final class TabBarViewModel: ObservableObject {

    enum Tab: Int {
        case myBike = 0
        case store
        case profile
    }

    @Published var selectedTab = 0

    var tabs: [Tab] = [.myBike, .store, .profile]
}

extension TabBarViewModel.Tab: Identifiable {

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .myBike: "Mina Cyklar"
        case .store: "Butik"
        case .profile: "Min Profil"
        }
    }

    var asset: String {
        switch self {
        case .myBike: "b"
        case .store: "c"
        case .profile: "k"
        }
    }
}
