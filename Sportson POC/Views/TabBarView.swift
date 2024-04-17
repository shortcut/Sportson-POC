//
//  TabBarView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct TabBarView: View {
    @InjectObject var store: Store
    @InjectObject var vm: TabBarViewModel
    private var activeTabButtonWidth = UIScreen.main.bounds.size.width * 0.5

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $vm.selectedTab) {
                ForEach(vm.tabs) { tab in
                    view(for: tab)
                        .tag(tab.rawValue)
                }
            }
            ZStack {
                HStack {
                    ForEach((vm.tabs), id: \.self){ item in
                        Button{
                            vm.selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.asset, title: item.title, isActive: (vm.selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 55)
            .background(Color.darkBg)
            .cornerRadius(27)
            .padding(.horizontal, 16)
            .onAppear(perform: {
                vm.selectedTab = 0
            })
            .onReceive(NotificationCenter.didRegisterBike) { _ in
                self.store.didRegisterBike = true
                self.store.isBikeRegistered = true
            }
        }
    }

    @ViewBuilder
    private func view(for tab: TabBarViewModel.Tab) -> some View {
        switch tab {
        case .myBike:
            MyBicycleView()
                .environmentObject(store)
        case .store:
            MainStoreView()
        case .profile:
            ProfileView()
        }
    }
}

extension TabBarView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 15){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 25, height: 25)
            if isActive{
                Text(title)
                    .textCase(.uppercase)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? activeTabButtonWidth : 60, height: 45)
        .background(isActive ? .yellow : .clear)
        .cornerRadius(30)
    }
}

#Preview {
    TabBarView()
}
