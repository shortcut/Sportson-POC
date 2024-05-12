//
//  AppConfig.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import Foundation
import ShortcutFoundation
import Core

struct AppConfig: Config {
    func configure(_ injector: Injector) {
        injector.map(Store.self) {
            Store()
        }

        injector.map(TabBarViewModel.self) {
            TabBarViewModel()
        }

        injector.map(BookingViewModel.self) {
            BookingViewModel()
        }
    }
}
