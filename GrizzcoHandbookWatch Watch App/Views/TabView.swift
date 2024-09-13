//
//  TabView.swift
//  Grizzco Handbook Watch App
//
//  Created by Ben Lawrence on 24/07/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
            WeaponView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
            BossView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
            SalmonRunListView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
        }
        .tabViewStyle(.verticalPage) // Use the correct page tab view stylex
    }
}

#Preview {
    NavigationStack {
        MainTabView()
    }
}
