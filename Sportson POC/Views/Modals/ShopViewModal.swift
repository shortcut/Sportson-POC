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

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(.gray.opacity(0.5))
                .frame(width: 45, height: 6)
                .padding(.top, 8)
            HStack {
                Text(store.currentCategoryTitle.uppercased())
                    .font(.emBold(size: 26))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            ScrollView {
                VStack {
                    ForEach(items) { item in
                        productSelection(item)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .background(Color.mainBg)
    }

    @ViewBuilder
    func productSelection(_ item: BikePart) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(item.image)
                    .resizable()
                    .frame(width: 90, height: 90)
                VStack(alignment: .leading) {
                    Text(item.brand.description().uppercased())
                        .font(.emBold(size: 16))
                    Text(item.description)
                        .font(.emBold(size: 14))
                    Text("\(item.price) kr")
                        .font(.emBold(size: 16))
                }
                .padding(.vertical, 4)
                Spacer()
                ZStack {
                    Circle().fill(Color.spYellow)
                        .frame(width: 30, height: 30)
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal, 16)
            .modifier(RoundedCardModifier())
        }
        .frame(height: 110)
    }
}

#Preview {
    ShopViewModal(currentType: .frame)
}
