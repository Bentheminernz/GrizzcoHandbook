//
//  BossView.swift
//  Grizzco Handbook Watch App
//
//  Created by Ben Lawrence on 24/07/2024.
//

import SwiftUI

struct BossView: View {
    @ObservedObject var stageFetcher = StageFetcher()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let setting = stageFetcher.currentSalmonRunSetting {
                    if let boss = setting.boss {
                        Text(boss.name)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        
                        Group {
                            if boss.name == "Horrorboros" {
                                Image("HorrorborosRotateIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.8)
                            } else if boss.name == "Cohozuna" {
                                Image("CohozunaRotateIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.8)
                            } else if boss.name == "Megalodontia" {
                                Image("MegalodontiaRotateIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.8)
                            } else if boss.name == "Triumvirate" {
                                Image("TriumvirateRotateIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.8)
                            } else if let imageURL = boss.image?.url {
                                AsyncImage(url: URL(string: imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.8)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    BossView()
}
