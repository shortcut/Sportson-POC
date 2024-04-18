//
//  MainStoreView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import Core

struct MainStoreView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 120)
                .background(Color.clear)
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Bikes")
                        .font(.system(.headline).bold())
                        .foregroundStyle(.yellow)
                        .padding(.top, 16)
                    HStack(spacing: 16) {
                        CategoryView(image: "bicycle", text: "Bikes")
                    }

                    Text("Bike parts")
                        .font(.system(.headline).bold())
                        .foregroundStyle(.yellow)
                        .padding(.top, 16)
                    HStack(spacing: 16) {
                        CategoryView(image: "bicycle", text: PartType.frame.rawValue.capitalized)
                        CategoryView(image: "bicycle", text: PartType.tires.rawValue.capitalized)
                    }

                    HStack(spacing: 16) {
                        CategoryView(image: "bicycle", text: PartType.wheels.rawValue.capitalized)
                        CategoryView(image: "bicycle", text: PartType.pedals.rawValue.capitalized)
                    }

                    HStack(spacing: 16) {
                        CategoryView(image: "bicycle", text: PartType.saddle.rawValue.capitalized)
                        CategoryView(image: "bicycle", text: PartType.handlebar.rawValue.capitalized)
                    }
                }
//                .frame(height: UIScreen.main.bounds.size.height)
//                .padding(.bottom, 70)
            }
            Rectangle().fill(.clear)
                .frame(height: 100)
        }
        .frame(height: UIScreen.main.bounds.size.height)
        .background(Color.mainBg)
        .modifier(FakeNavBarModifier(title: "STORE"))
    }
}

#Preview {
    MainStoreView()
}
