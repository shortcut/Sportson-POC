//
//  DottedLine.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 19. 4. 2024..
//

import SwiftUI

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    DottedLine()
        .stroke(style: .init(dash: [2]))
        .foregroundStyle(.gray.opacity(0.5))
                    .frame(height: 1)
}
