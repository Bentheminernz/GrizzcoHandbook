//
//  SalmonRunRow.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 16/06/2024.
//

import SwiftUI

struct SalmonRunRow: View {
    var setting: SalmonRunSetting
    var startTime: String?
    var endTime: String?
    @Binding var refreshTrigger: Bool
    @State private var selectedBossItem: Item?
    @State private var navigateToBossDetail: Bool = false
    @State private var showingPopup = false
    @State private var selectedWeapon: String?
    
    private var formattedStartTime: String {
        formatDateTime(startTime)
    }
    
    private var formattedEndTime: String {
        formatDateTime(endTime)
    }
    
    private var endDate: Date? {
        guard let endTime = endTime else { return nil }
        return ISO8601DateFormatter().date(from: endTime)
    }
    
    var body: some View {
        HStack {
            if let imageURL = setting.coopStage.thumbnailImage?.url, let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 75, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading) {
                if let _ = startTime, let _ = endTime {
                    Text("\(formattedStartTime) - \(formattedEndTime)")
                        .font(.subheadline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Text(setting.coopStage.name)
                    .font(.subheadline)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: true)
                    .minimumScaleFactor(0.5)
                
                HStack(spacing: 8) {
                    ForEach(setting.weapons, id: \.name) { weapon in
                        if let weaponURL = URL(string: weapon.image.url) {
                            ZStack {
                                AsyncImage(url: weaponURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 40, height: 40)
//                                        .onTapGesture {
//                                            withAnimation {
//                                                selectedWeapon = (selectedWeapon == weapon.name) ? nil : weapon.name
//                                            }
//                                        }
                                } placeholder: {
                                    Color.gray
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                }
                            }
//                            .overlay(
//                                Group {
//                                    if selectedWeapon == weapon.name {
//                                        Text(weapon.name)
//                                            .padding(10)
//                                            .background(Color.black.opacity(0.8))
//                                            .foregroundColor(.white)
//                                            .cornerRadius(10)
//                                            .offset(y: -40) // Adjust y-offset as needed
//                                            .transition(.scale)
//                                            .lineLimit(nil)
//                                            .multilineTextAlignment(.center)
//                                            .fixedSize(horizontal: false, vertical: true)
//                                            .frame(width: 120)
//                                            .alignmentGuide(.top) { $0[.bottom] } // Align the top of the text with the bottom of the circle to avoid shifting other elements
//                                    }
//                                }
//                            )
//                            .frame(width: 40, height: 40)
                        }
                    }
                }
                if let endDate = endDate {
                    CountdownView(targetDate: endDate, refreshTrigger: $refreshTrigger)
                        .font(.caption)
                }
            }
            
            Spacer()
            
            if let boss = setting.boss {
                let bossItem = getItemForBoss(bossName: boss.name)
                Button(action: {
                    selectedBossItem = bossItem
                }) {
                    bossImageView(for: boss)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(PlainButtonStyle()) // Ensures the button doesn't inherit any unwanted styles
            }
        }
        .navigationDestination(isPresented: Binding<Bool>(
            get: { selectedBossItem != nil },
            set: { if !$0 { selectedBossItem = nil } }
        )) {
            if let bossItem = selectedBossItem {
                GrizzcoDetail(item: bossItem)
            }
        }
    }
    
    private func formatDateTime(_ dateTimeString: String?) -> String {
        guard let dateTimeString = dateTimeString else { return "" }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // adjust according to your input format
        
        if let date = inputFormatter.date(from: dateTimeString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd-MM h:mm a" // output format
            
            return outputFormatter.string(from: date)
        }
        
        return dateTimeString
    }
    
    private func getItemForBoss(bossName: String) -> Item {
        switch bossName {
        case "Horrorboros":
            return Item.horrorborosInfo
        case "Cohozuna":
            return Item.cohozunaInfo
        case "Megalodontia":
            return Item.megalodontiaInfo
        case "Triumvirate":
            return Item.triumvirateInfo
        default:
            return Item(id: UUID().uuidString, displayedID: "N/A", name: bossName, description: "Description for \(bossName)", image: "nil", imageCaption: "Caption for \(bossName)", icon: "nil", sponsored: "False", sponsoredDescription: "nil")
        }
    }
    
    @ViewBuilder
    private func bossImageView(for boss: SalmonRunSetting.Boss?) -> some View {
        if let boss = boss {
            if boss.name == "Horrorboros" {
                Image("HorrorborosRotateIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if boss.name == "Cohozuna" {
                Image("CohozunaRotateIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if boss.name == "Megalodontia" {
                Image("MegalodontiaRotateIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if boss.name == "Triumvirate" {
                Image("TriumvirateRotateIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if let imageURL = boss.image?.url {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        } else {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        SalmonRunRow(setting: SalmonRunSetting.example, startTime: "2024-09-16T08:00:00Z", endTime: "2024-09-16T12:00:00Z", refreshTrigger: .constant(false))
    }
}
#endif
