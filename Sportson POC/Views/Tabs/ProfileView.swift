//
//  ProfileView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct ProfileView: View {
    @InjectObject var store: Store

    var body: some View {
        VStack(spacing: 20) {
            Group {
                userCard()
                companyCard()
            }
            .padding(.horizontal, 16)
        }
        .modifier(BackgroundModifier())
        .modifier(FakeNavBarModifier(icon: "k", title: "Min Profil"))
    }

    @ViewBuilder
    func userCard() -> some View {
        VStack {
            Group {
                HStack {
                    Text("Anne-Marie Svensson")
                        .font(.emBold(size: 26))
                    Spacer()
                }
                .padding(.top, 16)
                itemSelection("Inställingar")
                itemSelection("Logga ut")
                    .onTapGesture {
                        store.isUserLogged = false
                        store.userDidLogin = false
                    }
            }
            .padding(.horizontal, 16)
        }
        .modifier(RoundedCardModifier())
    }

    @ViewBuilder
    func companyCard() -> some View {
        VStack {
            Group {
                HStack {
                    Text("Sportson")
                        .font(.emBold(size: 26))
                    Spacer()
                }
                .padding(.top, 16)
                itemSelection("Integritetspolicy")
                itemSelection("Vilkor")
                itemSelection("Om oss")
            }
            .padding(.horizontal, 16)
        }
        .modifier(RoundedCardModifier())
    }

    @ViewBuilder
    func itemSelection(_ text: String) -> some View {
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
            Rectangle().fill(.gray.opacity(0.7))
                .frame(width: .infinity, height: 1)
        }
        .frame(height: 60)
    }
}

#Preview {
    ProfileView()
}
