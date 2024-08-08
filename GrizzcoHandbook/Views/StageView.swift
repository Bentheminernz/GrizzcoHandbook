//
//  StageView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 16/06/2024.
//

import SwiftUI

struct StageView: View {
    @ObservedObject var stageFetcher = StageFetcher()
    @Environment(\.colorScheme) var colorScheme
    @State private var countdown: String = ""
    @State private var showingPopup = false
    @State private var selectedWeapon: String?

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    if let setting = stageFetcher.currentSalmonRunSetting {
                        VStack(spacing: 10) {
                            Text(setting.coopStage.name)
                                .font(.title2)
                                .padding(.top, 0)
                                .bold()
                        
                            if let imageURL = setting.coopStage.thumbnailImage?.url {
                                AsyncImage(url: URL(string: imageURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(25)
                                        .shadow(radius: 7)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.3)
                                .padding()
                            }
                            
                            Text("Weapon Rotation")
                                .font(.title2)
                                .padding(.top)
                                .bold()

                            HStack(spacing: 20) {
                                ForEach(setting.weapons, id: \.name) { weapon in
                                    VStack {
                                        ZStack {
                                            AsyncImage(url: URL(string: weapon.image.url)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.main.bounds.width * 0.2)
                                                    .onTapGesture {
                                                        withAnimation {
                                                            selectedWeapon = (selectedWeapon == weapon.name) ? nil : weapon.name
                                                        }
                                                    }
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            
                                            if selectedWeapon == weapon.name {
                                                Text(weapon.name)
                                                    .padding(10)
                                                    .background(Color.black.opacity(0.8))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                                    .offset(y: -75) // Position the popup above the image
                                                    .transition(.scale)
                                                    .lineLimit(nil) // Allow text to wrap to multiple lines
                                                    .multilineTextAlignment(.center) // Center align the text
                                                    .fixedSize(horizontal: false, vertical: true) // Ensure the text view resizes vertically
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.bottom)
                            .frame(height: 100)

                            if let boss = setting.boss {
                                Text("Current Boss")
                                    .font(.title2)
                                    .padding(.top)
                                    .bold()

                                Text(boss.name)
                                    .font(.headline)
                                    .padding(.bottom, 5)

                                VStack {
                                    if boss.name == "Horrorboros" {
                                        NavigationLink(destination: GrizzcoDetail(item: Item.horrorborosInfo)) {
                                            Image("HorrorborosRotateIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.main.bounds.width * 0.3)
                                        }
                                    } else if boss.name == "Cohozuna" {
                                        NavigationLink(destination: GrizzcoDetail(item: Item.cohozunaInfo)) {
                                            Image("CohozunaRotateIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.main.bounds.width * 0.3)
                                        }
                                    } else if boss.name == "Megalodontia" {
                                        NavigationLink(destination: GrizzcoDetail(item: Item.megalodontiaInfo)) {
                                            Image("MegalodontiaRotateIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.main.bounds.width * 0.3)
                                        }
                                    } else if boss.name == "Triumvirate" {
                                        NavigationLink(destination: GrizzcoDetail(item: Item.triumvirateInfo)) {
                                            Image("TriumvirateRotateIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.main.bounds.width * 0.3)
                                        }
                                    } else if let imageURL = boss.image?.url {
                                        AsyncImage(url: URL(string: imageURL)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.main.bounds.width * 0.4)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity) // Center the VStack horizontally
                                .frame(height: 130)
                            }
                            Spacer()
                        }
                        .padding()
                        .multilineTextAlignment(.center)
                    } else {
                        ProgressView()
                            .onAppear {
                                stageFetcher.fetchData()
                            }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(
                    colorScheme == .dark ?
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: Color(hue: 0.096, saturation: 1.0, brightness: 1.0, opacity: 1.0), location: 0.115),
                                Gradient.Stop(color: Color(hue: 0.096, saturation: 0.698, brightness: 1.0, opacity: 1.0), location: 0.286),
                                Gradient.Stop(color: Color(hue: 0.15, saturation: 0.0, brightness: 0.0, opacity: 1.0), location: 1.0),
                                Gradient.Stop(color: Color(hue: 0.552, saturation: 1.0, brightness: 1.0, opacity: 0.0), location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ) :
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: Color(hue: 0.097, saturation: 1.0, brightness: 1.0, opacity: 1.0), location: 0.0),
                                Gradient.Stop(color: Color(hue: 0.096, saturation: 0.496, brightness: 0.956, opacity: 1.0), location: 0.350),
                                Gradient.Stop(color: Color(hue: 0.097, saturation: 0.451, brightness: 1.0, opacity: 1.0), location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                )

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
            .navigationTitle("Map Rotation")
        }
        .onAppear {
            startCountdown()
            checkForNewMapRotation()
        }
    }

    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let nextScheduleStartTime = stageFetcher.nextScheduleStartTime {
                let timeInterval = nextScheduleStartTime.timeIntervalSince(Date())
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

#if DEBUG
struct MainView: View {
    @StateObject private var stageFetcher = StageFetcher()
    @State private var scheduleType = 0
    
    var body: some View {
        Picker(selection: $scheduleType, label: Text("Picker"), content: {
            Text("Freelance").tag(0)
            Text("Eggstra Work").tag(1)
        })
        .pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: 230)
        .background(Color.clear)
        if scheduleType == 0 {
            StageView()
        } else {
            EggstraWorkView()
        }
    }
}
#endif

#Preview {
    StageView()
}
