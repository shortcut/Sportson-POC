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

    @Published var selectedTab = Tab.myBike.rawValue

    var tabs: [Tab] = [.myBike, .store, .profile]
}

extension TabBarViewModel.Tab: Identifiable {

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .myBike: "My Bike"
        case .store: "Store"
        case .profile: "Profile"
        }
    }

    var asset: String {
        switch self {
        case .myBike: "bicycle.circle"
        case .store: "storefront.circle"
        case .profile: "person.crop.circle"
        }
    }
}
