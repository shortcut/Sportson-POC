//
//  NotificationCenter+Extension.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 17. 4. 2024..
//

import Foundation
import Combine

public extension NotificationCenter {
    static var didRegisterBike: AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: .didRegisterBike)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
