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
    @Published var selectedPhoneNumber: String = .empty 

    @Published var hasSelectedCity = false
    @Published var hasSelectedDate = false
    @Published var hasAcceptedTerms = false
    var hasGivenPhone: Bool {
        selectedPhoneNumber.count >= 9 && hasAcceptedTerms
    }

}
