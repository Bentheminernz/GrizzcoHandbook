//
//  CountdownView.swift
//  Grizzco Handbook Watch App
//
//  Created by Ben Lawrence on 24/07/2024.
//

import SwiftUI

struct CountdownView: View {
    @ObservedObject var stageFetcher = StageFetcher()
    @State private var countdown: String = ""

    var body: some View {
        VStack {
            Text(countdown)
                .font(.largeTitle)
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding()
                .onAppear {
                    startCountdown()
                }
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
}

#Preview {
    CountdownView()
}
