//
//  SportsonClipApp.swift
//  SportsonClip
//
//  Created by Marco-Shortcut on 23. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

@main
struct SportsonClipApp: App {
    let context = Context(AppClipConfig())

    @InjectObject private var store: Store

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .onContinueUserActivity(
                    NSUserActivityTypeBrowsingWeb,
                    perform: handleUserActivity)
        }
    }

    func handleUserActivity(_ userActivity: NSUserActivity) {
        guard
            let incomingURL = userActivity.webpageURL,
            let components = URLComponents(
                url: incomingURL,
                resolvingAgainstBaseURL: true)
//            let queryItems = components.queryItems
        else {
            return
        }

//        guard let serialNumberValue = queryItems.first(where: { $0.name == "serial" })?.value else {
//            return
//        }
//
//        let serialNumber = serialNumberValue.description

        store.didRegisterBike = true
        store.didRegisterBike = true
        store.savedSerialNumber = "546354"

        print("Sportson clip test 1 \(store.savedSerialNumber)")
    }
}
