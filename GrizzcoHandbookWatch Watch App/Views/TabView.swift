//
//  TabView.swift
//  Grizzco Handbook Watch App
//
//  Created by Ben Lawrence on 24/07/2024.
//

import SwiftUI

struct MainTabView: View { // Renamed to avoid confusion with the system TabView
    var body: some View {
        TabView {
            ContentView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
                .navigationTitle {
                    Text("Map").foregroundColor(.white)
                }
            WeaponView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
                .navigationTitle {
                    Text("Weapons").foregroundColor(.white)
                }
            BossView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
                .navigationTitle {
                    Text("Boss").foregroundColor(.white)
                }
            CountdownView()
                .font(.caption)
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
                .navigationTitle {
                    Text("Next Map").foregroundColor(.white)
                }
            SalmonRunListView()
                .containerBackground(Gradient(colors: [.orange, .black]), for: .tabView)
                .navigationTitle {
                    Text("Boss").foregroundColor(.white)
                }
        }
        .tabViewStyle(.verticalPage) // Use the correct page tab view stylex
    }
}

#Preview {
    NavigationStack {
        MainTabView()
    }
}
