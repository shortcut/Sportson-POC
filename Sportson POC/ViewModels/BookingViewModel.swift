//
//  BookingViewModel.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 12. 5. 2024..
//

import Foundation
import SwiftUI
import ShortcutFoundation
import Core

final class BookingViewModel: ObservableObject {
    enum City: String, CaseIterable, Identifiable {
        case stockholm, göteborg, malmö, none
        var id: Self { self }

        func description() -> String {
            switch self {
            case .none:
                "Välj butik"
            default:
                self.rawValue.capitalized
            }
        }
    }

    enum Service: String, CaseIterable, Identifiable {
        case general, punkt, shift, brake, other
        var id: Self { self }

        func description() -> String {
            switch self {
            case .general:
                return "Allmän Service"
            case .punkt:
                return "Punktering"
            case .shift:
                return "Växlar"
            case .brake:
                return "Bromsar"
            case .other:
                return "M.fl."
            }
        }
    }

    let availableDates = Booking.availableDates()

    @Published var selectedPageIndex: Int = 0

    @Published var selectedCity: City = .none {
        didSet {
            hasSelectedCity = selectedCity != .none
        }
    }
    @Published var selectedDate: String = .empty {
        didSet {
            hasSelectedDate = selectedDate != .empty
        }
    }
    @Published var selectedService: Service = .general {
        didSet {
            hasSelectedService = selectedService != .other
        }
    }
    @Published var selectedPhoneNumber: String = .empty
    @Published var selectedCode: String = .empty
    @Published var extraInfo: String = .empty

    @Published var hasSelectedCity = false
    @Published var hasSelectedDate = false
    @Published var hasAcceptedTerms = false
    var hasGivenPhone: Bool {
        selectedPhoneNumber.count >= 9 && hasAcceptedTerms
    }
    var hasGivenCode: Bool {
        selectedCode.count >= 5
    }
    @Published var hasSelectedService = false
    @Published var hasChosenPush = false
    @Published var hasChosenSMS = false
    @Published var hasChosenEmail = false
}
