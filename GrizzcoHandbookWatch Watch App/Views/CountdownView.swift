//
//  CountdownView.swift
//  Grizzco Handbook Watch App
//
//  Created by Ben Lawrence on 24/07/2024.
//

import SwiftUI

struct CountdownView: View {
    var startTime: String?
    var endTime: String?
    @ObservedObject var stageFetcher = StageFetcher()
    @State private var countdown: String = ""
    
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
        VStack {
            if let _ = startTime, let _ = endTime {
                Text("\(formattedStartTime) - \(formattedEndTime)")
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
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
}

#Preview {
    CountdownView()
}
