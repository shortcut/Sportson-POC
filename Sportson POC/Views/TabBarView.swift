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
    private var activeTabButtonWidth = UIScreen.main.bounds.size.width * 0.4

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $vm.selectedTab) {
                ForEach(vm.tabs) { tab in
                    view(for: tab)
                        .tag(tab.rawValue)
                }
            }
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
            .frame(height: 55)
            .background(Color.darkBg)
            .cornerRadius(27)
            .padding(.horizontal, 16)
        }
        .onAppear(perform: {
            vm.selectedTab = 0
        })
        .onReceive(NotificationCenter.didRegisterBike) { _ in
            self.store.didRegisterBike = true
            self.store.isBikeRegistered = true
        }
        .sheet(isPresented: $store.shouldPresentCategoryShop) {
            ShopViewModal(currentType: store.currentCategory)
        }
        .sheet(isPresented: $store.shouldPresentBikeModal) {
            MyBikeModal()
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
            Text(imageName)
                .font(.sportson(size: 32))
                .foregroundColor(isActive ? .black : .gray)
            if isActive{
                Text(title)
                    .font(.emRegular(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
        }
        .frame(width: isActive ? activeTabButtonWidth : 80, height: 45)
        .background(isActive ? Color.spYellow : .clear)
        .cornerRadius(30)
    }
}

#Preview {
    TabBarView()
}
