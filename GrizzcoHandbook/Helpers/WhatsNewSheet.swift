//
//  WhatsNewSheet.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 8/9/24.
//

import SwiftUI
import WhatsNewKit

struct WhatsNewSheet: View {
    var body: some View {
        whatsNewSheet() 
    }

    func whatsNewSheet() -> WhatsNewView {
        let features = [
            WhatsNew.Feature(
                image: .init(systemName: "graduationcap.fill"),
                title: "New Field Guide Information",
                subtitle: "New information about King Salmonids has been added!"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "line.3.horizontal.decrease.circle"),
                title: "Filter Items",
                subtitle: "Filter items in the Employee Handbook and Field Guide by section!"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "map.fill"),
                title: "Map Rotation Additions",
                subtitle: "Click on King Salmonid icons to see info about them!"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "info.bubble"),
                title: "Weapon Names",
                subtitle: "Click on weapon icons to see their names!"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "filemenu.and.selection"),
                title: "Reordered Tab Bar",
                subtitle: "Reorders Tab Bar so Field Guide is now the default tab!"
            )
        ]
        
        let whatsNew = WhatsNew(
            version: "1.1.0",
            title: "Welcome to Grizzco Handbook",
            features: features
        )

        return WhatsNewView(whatsNew: whatsNew)
    }
}

#Preview {
    WhatsNewSheet()
}
