//
//  tabView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 15/6/2024.
//

import SwiftUI

struct tabView: View {
    var body: some View {
        TabBarControllerRepresentable()
            .edgesIgnoringSafeArea(.all) // This ensures the tab bar fills the screen
    }
}

#Preview {
    tabView()
}
