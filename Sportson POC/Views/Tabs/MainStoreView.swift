//
//  MainStoreView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct MainStoreView: View {
    @InjectObject var store: Store
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Text("Kategorier")
                            .font(.emBold(size: 26))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    ScrollView(showsIndicators: false) {
                        Group {
                            categorySelection("Cykelbarnstolar")
                            categorySelection("Barntillbehör")
                            categorySelection("Cykelbelysning")
                            categorySelection("Cykeldator")
                            categorySelection("CykelDäck")
                            categorySelection("Cykelflaskor och flaskhållar")
                            categorySelection("Cykelglasögon")
                            categorySelection("Cykelhandtag och styrlindor")
                            categorySelection("CykelHjälmar")
                            categorySelection("Cykelhjul")
                        }
                        .padding(.horizontal,16)
                    }
                }
                .frame(height: UIScreen.main.bounds.size.height - 250)
                .modifier(RoundedCardModifier())
                .padding([.top, .horizontal], 16)
            }
            Spacer()
        }
        .modifier(BackgroundModifier())
        .modifier(FakeNavBarModifier(icon: "c", title: "Butik"))
    }

    @ViewBuilder
    func categorySelection(_ text: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(text)
                    .font(.emRegular(size: 16))
                Spacer()
                ZStack {
                    Circle().fill(Color.spYellow)
                        .frame(width: 30, height: 30)
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.vertical, 16)
            DottedLine()
                .stroke(style: .init(dash: [2]))
                .foregroundStyle(.gray.opacity(0.5))
                            .frame(height: 1)
        }
        .frame(height: 60)
        .onTapGesture {
            store.shouldPresentCategoryShop = true
            store.currentCategoryTitle = text
            store.currentCategory = PartType.allCases.randomElement() ?? .frame
        }
    }
}

#Preview {
    MainStoreView()
}
