//
//  SportsonClipApp.swift
//  SportsonClip
//
//  Created by Marco-Shortcut on 23. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core
import UserNotifications

@main
struct SportsonClipApp: App {
    let context = Context(AppClipConfig())
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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

final class AppDelegate: NSObject, UIApplicationDelegate {
    @Inject var notifications: INotifications

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        notifications.setup()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                self.removeDelivered()
                self.notifications.scheduleRequest(for: .welcome, details: .empty)
                print("Notification authorization granted")
            } else {
                self.removeAll()
                print("Notification authorization denied")
            }
        }
        return true
    }

    private func removeAll() {
        removeDelivered()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func removeDelivered() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
