//
//  UpcomingCountdown.swift
//  GrizzcoHandbookWatch Watch App
//
//  Created by Ben Lawrence on 16/8/24.
//

import SwiftUI

struct UpcomingCountdown: View {
    let targetDate: Date
    @Binding var refreshTrigger: Bool
    @State private var remainingTime: String = ""

    var body: some View {
        Text(remainingTime)
            .onAppear(perform: updateRemainingTime)
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                updateRemainingTime()
            }
    }

    private func updateRemainingTime() {
        let timeInterval = targetDate.timeIntervalSince(Date())
        if timeInterval > 0 {
            let days = Int(timeInterval) / 86400
            let hours = (Int(timeInterval) % 86400) / 3600
            let minutes = (Int(timeInterval) % 3600) / 60
            let seconds = Int(timeInterval) % 60
            remainingTime = String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
        } else {
            remainingTime = "00:00:00:00"
            refreshTrigger.toggle() // Trigger a refresh
        }
    }
}
