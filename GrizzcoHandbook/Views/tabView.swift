//  tabView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 15/6/2024.
//

import SwiftUI

struct tabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Handbook", systemImage: "text.book.closed.fill")
                }
                .toolbarBackground(colorScheme == .light ? Color(red: 255/255, green: 215/255, blue: 140/255) : Color(red: 0/255, green: 0/255, blue: 0/255), for: .tabBar)
            
            FieldGuide()
                .tabItem {
                    Label("Field Guide", systemImage: "graduationcap.fill")
                }
                .toolbarBackground(colorScheme == .light ? Color(red: 255/255, green: 215/255, blue: 140/255) : Color(red: 0/255, green: 0/255, blue: 0/255), for: .tabBar)
            
            StageView()
                .tabItem {
                    Label("Map Rotation", systemImage: "map.fill")
                }
                .toolbarBackground(colorScheme == .light ? Color(red: 255/255, green: 215/255, blue: 140/255) : Color(red: 0/255, green: 0/255, blue: 0/255), for: .tabBar)
            
            SalmonRunListView()
                .tabItem {
                    Label("Map Schedule", systemImage: "calendar")
                }
                .toolbarBackground(colorScheme == .light ? Color(red: 255/255, green: 215/255, blue: 140/255) : Color(red: 0/255, green: 0/255, blue: 0/255), for: .tabBar)
        }
    }
}

#Preview {
    tabView()
}
