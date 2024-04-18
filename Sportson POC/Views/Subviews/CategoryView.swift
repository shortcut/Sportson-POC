//
//  CategoryView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 18. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct CategoryView: View {
    @InjectObject var store: Store

    var image: String
    var text: String

    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 48, height: 48)
                .padding()
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundStyle(.yellow)
        }
        .padding()
        .frame(width: (UIScreen.main.bounds.size.width - 100) / 2, height: 130)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.darkBg))
        .overlay(
            RoundedRectangle(cornerRadius: 10) // Define the shape of the overlay
                .stroke(Color.yellow, lineWidth: 2)  // Set the color and line width of the border
        )
        .onTapGesture {
            store.shouldPresentCategoryShop = true
            store.currentCategory = PartType.typeFrom(text)
        }
    }
}

#Preview {
    HStack {
        CategoryView(image: "bicycle", text: "Handlebars")
        CategoryView(image: "bicycle", text: "Bikes")
    }
}
