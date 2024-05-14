//
//  NotificationManager.swift
//
//
//  Created by Marco-Shortcut on 14. 5. 2024..
//

import Foundation
import UserNotifications
import ShortcutFoundation
import Core

public enum NotificationIdentifier: String {
    case welcome
    case serviceBooked

    func title() -> String {
        switch self {
        case .welcome:
            "Höstjustering väntar!"
        case .serviceBooked:
            "Bekräftelse på bokning"
        }
    }

    func body(details: String = .empty) -> String {
        switch self {
        case .welcome:
            "🍁 Boka din cykelservice nu och få 15% rabatt. Giltig till 22 sep. Rulla in hos oss!"
        case .serviceBooked:
            "🛠️ Klar och bokad! Vi ses för din cykelservice den \(details) kl. 13:00."
        }
    }

    func link() -> String {
        switch self {
        case .welcome:
            "service"
        case .serviceBooked:
            ""
        }
    }
}

public protocol INotifications: UNUserNotificationCenterDelegate {
    func setup()
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async
    func scheduleRequest(for identifier: NotificationIdentifier, details: String)
}

public final class NotificationManager: NSObject, INotifications {
    @InjectObject var store: Store
    private let center = UNUserNotificationCenter.current()

    override public init() {}

    public func setup() {
        center.delegate = self
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.banner, .sound, .list, .badge]
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        if let link = userInfo["link"] as? String {
            openLink(link)
        }
    }

    public func scheduleRequest(for identifier: NotificationIdentifier, details: String) {
        let content = UNMutableNotificationContent()
        content.title = identifier.title()
        content.body = identifier.body(details: details)
        content.sound = UNNotificationSound.default

        content.userInfo["link"] = identifier.link()

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }

    private func openLink(_ link: String) {
        if link == "service" {
            store.shouldPresentService = true
        }
    }
}
