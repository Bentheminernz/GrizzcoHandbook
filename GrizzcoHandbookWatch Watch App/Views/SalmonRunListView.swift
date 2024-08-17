//
//  SalmonRunListView.swift
//  GrizzcoHandbookWatch Watch App
//
//  Created by Ben Lawrence on 16/8/24.
//

import SwiftUI

struct SalmonRunListView: View {
    @StateObject private var fetcher = StageFetcher()
    @State private var refreshTrigger = false

    var body: some View {
        NavigationStack {
            List(upcomingSalmonRunSettings) { node in
                SalmonRunRow(setting: node.setting, startTime: node.startTime, endTime: node.endTime, refreshTrigger: $refreshTrigger)
            }
            .onChange(of: refreshTrigger) {
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
