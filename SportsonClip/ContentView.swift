//
//  ContentView.swift
//  SportsonClip
//
//  Created by Marco-Shortcut on 23. 4. 2024..
//

import SwiftUI
import Core

struct ContentView: View {
    @EnvironmentObject private var store: Store

    var body: some View {
        VStack() {
            if store.isBikeRegistered || store.didRegisterBike {
                    bikeDetailView()
                        .padding(.horizontal, 16)
                        .padding(.top, 70)
                    Button(action:  { },label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.gray)
                            Text("Ändra innehåll")
                                .font(.emRegular(size: 14))
                                .foregroundColor(.gray)
                        }
                    })
                    .frame(height: 50)
                    .buttonStyle(CapsuleButtonClearStyle())
            } else {
                emptyStateView
            }
        }
        .modifier(BackgroundModifier())
        .modifier(FakeNavBarModifier(icon: "b", title: "Mina Cyklar"))
        .sheet(isPresented: $store.shouldPresentBikeModal) {
            MyBikeModal()
        }
    }

    var emptyStateView: some View {
        VStack {
            Button(action:  {},label: {
                HStack {
                    Text("Något gick fel!")
                        .font(.emRegular(size: 22))
                }
                .frame(width: UIScreen.main.bounds.size.width * 0.8)
            })
            .padding(.top, 140)
            .buttonStyle(CapsuleButtonYellowStyle())
        }
    }

    @ViewBuilder
    func bikeDetailView() -> some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Cresent".uppercased())
                        .font(.emSemiBold(size: 14))
                    Text("Elina")
                        .font(.emBold(size: 26))
                }
                .foregroundColor(.black)
                Spacer()
                Text("Ramnummer: \(store.registeredSerialNumber)")
                    .font(.emRegular(size: 14))
                    .foregroundStyle(.gray)
            }
            .padding(.top, 8)
            Image("myBike")
                .resizable()
                .scaledToFit()

            myBikeSelection("Produktinformation")
            myBikeSelection("Teknisk specifikation")
            myBikeSelection("Tillbehör")
                .onTapGesture {
                    store.shouldPresentBikeModal = true
                }
            myBikeSelection("Boka cykelservice")
        }
        .padding(.horizontal, 16)
        .modifier(RoundedCardModifier())
    }

    @ViewBuilder
    func myBikeSelection(_ text: String) -> some View {
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
                .stroke(style: .init(dash: [10]))
                .foregroundStyle(.gray.opacity(0.5))
                            .frame(height: 1)
        }
        .frame(height: 60)
    }
}

#Preview {
    ContentView()
}
