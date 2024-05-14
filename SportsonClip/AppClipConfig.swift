//
//  AppClipConfig.swift
//  SportsonClip
//
//  Created by Marco-Shortcut on 23. 4. 2024..
//

import Foundation
import ShortcutFoundation
import Core


struct AppClipConfig: Config {
    func configure(_ injector: Injector) {
        injector.map(Store.self) {
            Store()
        }

        injector.map(BookingViewModel.self) {
            BookingViewModel()
        }

        injector.map(INotifications.self) {
            NotificationManager()
        }
    }
}
