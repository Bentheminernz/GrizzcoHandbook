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
                image: .init(systemName: "applewatch"),
                title: "New Apple Watch App Features",
                subtitle: "Explore the new refined design and see upcoming map rotations!"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "iphone.gen3"),
                title: "Updated for iOS 18",
                subtitle: "Grizzco Handbook now supports iOS 18 and its new features!"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "ladybug.circle"),
                title: "Bug Fixes!",
                subtitle: "Many bug fixes and improvements!"
            )
        ]
        
        let whatsNew = WhatsNew(
            version: "1.2.0",
            title: "Welcome to Grizzco Handbook",
            features: features
        )

        return WhatsNewView(whatsNew: whatsNew)
    }
}

#Preview {
    WhatsNewSheet()
}
