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
            .background(BackgroundGradient(colorScheme: colorScheme).customBackground)
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
