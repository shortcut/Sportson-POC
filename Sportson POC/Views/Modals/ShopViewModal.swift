//
//  ShopViewModal.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 18. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct ShopViewModal: View {
    @InjectObject var store: Store

    var currentType: PartType

    var items: [BikePart] {
        BikePart.allParts().filter { $0.type == currentType }
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        Text(store.currentCategory.rawValue.uppercased())
            .fontWeight(.bold)
            .font(.title2)
        ScrollView {
            // Using LazyVGrid to create a grid layout
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { item in
                    VStack {
                        Image(item.image)
                            .resizable()
                            .frame(width: 150, height: 150)
                        VStack(alignment: .leading) {
                            Text("Product: \(item.type.rawValue)")
                            Text("Price: $\(item.price).00")
                            Text("Brand: \(item.brand)")
                        }
                    }
                        .frame(minHeight: 200) // Minimum height for each cell
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Define the shape of the overlay
                                .stroke(Color.black, lineWidth: 1)  // Set the color and line width of the border
                        )
                        .cornerRadius(10)
                }
            }
            .padding() // Padding around the grid
        }
    }
}

#Preview {
    ShopViewModal(currentType: .frame)
}
