//
//  WeaponView.swift
//  Grizzco Handbook Watch App
//
//  Created by Ben Lawrence on 24/07/2024.
//

import SwiftUI

struct WeaponView: View {
    @ObservedObject var stageFetcher = StageFetcher()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let setting = stageFetcher.currentSalmonRunSetting {
                ForEach(setting.weapons, id: \.name) { weapon in
                    HStack {
                        AsyncImage(url: URL(string: weapon.image.url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(weapon.name)
                            .bold()
                    }
                }
            } else {
                Text("An error has occured")
            }
        }
    }
}

#Preview {
    WeaponView()
}
