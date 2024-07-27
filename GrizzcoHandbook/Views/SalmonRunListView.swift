//
//  SalmonRunListView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 16/06/2024.
//

import SwiftUI

struct SalmonRunListView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var fetcher = StageFetcher()
    @State private var refreshTrigger = false

    var body: some View {
        NavigationStack {
            List(upcomingSalmonRunSettings) { node in
                SalmonRunRow(setting: node.setting, startTime: node.startTime, endTime: node.endTime, refreshTrigger: $refreshTrigger)
                    .listRowBackground(Color.white.opacity(0.1)) // Background for each row
            }
            .scrollContentBackground(.hidden)
            .background(colorScheme == .dark ? LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.09630024002259037, saturation: 1.0, brightness: 1.0, opacity: 1.0), location: 0.11563251201923075), Gradient.Stop(color: Color(hue: 0.09630024002259037, saturation: 0.6989510777484941, brightness: 1.0, opacity: 1.0), location: 0.28639573317307687), Gradient.Stop(color: Color(hue: 0.15, saturation: 0.0, brightness: 0.0, opacity: 1.0), location: 1.0), Gradient.Stop(color: Color(hue: 0.5522990399096386, saturation: 1.0, brightness: 1.0, opacity: 0.0), location: 1.0)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom) : LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.09709443241716868, saturation: 1.0, brightness: 1.0, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.09645025414156627, saturation: 0.49645849021084343, brightness: 0.9569400649472892, opacity: 1.0), location: 0.3506310096153846), Gradient.Stop(color: Color(hue: 0.09729739269578314, saturation: 0.4518425263554217, brightness: 1.0, opacity: 1.0), location: 1.0)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom))
            .navigationTitle("Map Schedule")
            .onChange(of: refreshTrigger) { _ in
                fetcher.fetchData()
            }
        }
    }

    private var upcomingSalmonRunSettings: [ScheduleNode] {
        let currentDate = Date()
        return fetcher.salmonRunSettings.filter { node in
            guard let startTime = ISO8601DateFormatter().date(from: node.startTime),
                  let endTime = ISO8601DateFormatter().date(from: node.endTime) else {
                return false
            }
            return currentDate < startTime || currentDate > endTime
        }
    }
}

#Preview {
    SalmonRunListView()
}
