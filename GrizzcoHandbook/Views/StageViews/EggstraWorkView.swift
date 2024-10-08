//
//  EggstraWorkView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 21/07/2024.
//

import SwiftUI

struct EggstraWorkView: View {
    @ObservedObject var stageFetcher = StageFetcher()
    @Environment(\.colorScheme) var colorScheme
    @State private var countdown: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    if let setting = stageFetcher.eggstraWorkSettings.first?.setting {
                        VStack(spacing: 10) {  // Reduce spacing between title and map name
                            Text(setting.coopStage.name)
                                .font(.title3)
                                .padding(.top, 0) // Remove top padding

                            if let imageURL = setting.coopStage.thumbnailImage?.url {
                                AsyncImage(url: URL(string: imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300)
                                        .cornerRadius(25)
                                        .shadow(radius: 7)
                                } placeholder: {
                                    ProgressView()
                                }
                            }

                            Text("Weapon Rotation")
                                .font(.title2)
                                .padding(.top)
                                .bold()

                            HStack(spacing: 20) {
                                ForEach(setting.weapons, id: \.name) { weapon in
                                    VStack {
                                        AsyncImage(url: URL(string: weapon.image.url)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 75, height: 75)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .multilineTextAlignment(.center)
                    } else {
                        ProgressView()
                            .onAppear {
                                stageFetcher.fetchData()
                            }
                    }
                    Spacer()
                }
                .scrollContentBackground(.hidden)
                .background(BackgroundGradient(colorScheme: colorScheme).customBackground)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(countdown)
                            .font(.headline)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            .navigationTitle("Eggstra Work")
        }
        .onAppear {
            startCountdown()
            checkForNewMapRotation()
        }
    }

    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let eggstraWorkEndTime = stageFetcher.eggstraWorkSettings.first?.endTime {
                let endTime = ISO8601DateFormatter().date(from: eggstraWorkEndTime) ?? Date()
                let timeInterval = endTime.timeIntervalSince(Date())
                if timeInterval > 0 {
                    let hours = Int(timeInterval) / 3600
                    let minutes = Int(timeInterval) % 3600 / 60
                    let seconds = Int(timeInterval) % 60
                    countdown = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                } else {
                    countdown = "00:00:00"
                }
            }
        }
    }

    func checkForNewMapRotation() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            stageFetcher.fetchData()
        }
    }
}

#Preview {
    EggstraWorkView()
}
