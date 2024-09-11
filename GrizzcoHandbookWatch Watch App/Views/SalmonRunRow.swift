//
//  SalmonRunRow.swift
//  GrizzcoHandbookWatch Watch App
//
//  Created by Ben Lawrence on 16/8/24.
//

import SwiftUI

struct SalmonRunRow: View {
    var setting: SalmonRunSetting
    var startTime: String?
    var endTime: String?
    @Binding var refreshTrigger: Bool
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
//            if let imageURL = setting.coopStage.thumbnailImage?.url, let url = URL(string: imageURL) {
//                AsyncImage(url: url) { image in
//                    image.resizable()
//                         .scaledToFill()
//                } placeholder: {
//                    Color.gray
//                }
//                .frame(width: 75, height: 50)
//                .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
            
            VStack(alignment: .leading) {
//                if let _ = startTime, let _ = endTime {
//                    Text("\(formattedStartTime) - \(formattedEndTime)")
//                        .font(.subheadline)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.5)
//                        .fixedSize(horizontal: false, vertical: true)
//                }
                
                Text(setting.coopStage.name)
                    .font(.caption2)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: true)
                    .minimumScaleFactor(0.5)
                
                HStack(spacing: 3) {
                    ForEach(setting.weapons, id: \.name) { weapon in
                        if let weaponURL = URL(string: weapon.image.url) {
                            ZStack {
                                AsyncImage(url: weaponURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 30, height: 30)
                               } placeholder: {
                                    Color.gray
                                        .frame(width: 25, height: 25)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    Spacer()
                    if let boss = setting.boss {
                        bossImageView(for: boss)
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.trailing)
                    }
                }
                if let endDate = endDate {
                    UpcomingCountdown(targetDate: endDate, refreshTrigger: $refreshTrigger)
                        .font(.caption2)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: true)
                }
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
        SalmonRunRow(setting: SalmonRunSetting.example, startTime: "2024-08-18T08:00:00Z", endTime: "2024-08-19T12:00:00Z", refreshTrigger: .constant(false))
    }
}
#endif
