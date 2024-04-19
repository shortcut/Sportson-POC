//
//  Font+Extension.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 19. 4. 2024..
//

import Foundation
import SwiftUI

extension Font {
    static func emRegular(size: CGFloat = 14) -> Font {
        return Font.custom("FSEmericWeb-Book", size: size)
    }

    static func emSemiBold(size: CGFloat = 14) -> Font {
        return Font.custom("FSEmericWeb-Core", size: size)
    }

    static func emBold(size: CGFloat = 14) -> Font {
        return Font.custom("FSEmericWeb-Medium", size: size)
    }

    static func emSemiBoldItalic(size: CGFloat = 14) -> Font {
        return Font.custom("FSEmericWeb-CoreItalic", size: size)
    }

    static func sportson(size: CGFloat = 14) -> Font {
        return Font.custom("sportson", size: size)
    }
}
