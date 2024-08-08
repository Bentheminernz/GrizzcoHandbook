//
//  ContentView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 15/6/2024.
//

import SwiftUI
import WhatsNewKit

struct ContentView: View {
    @State private var sponsorTest = false
    
    var items: [ItemSection] {
        if sponsorTest {
            return Bundle.main.decode([ItemSection].self, from: "handbookSponsorTest.json")
        } else {
            return Bundle.main.decode([ItemSection].self, from: "handbook.json")
        }
    }
    @Environment(\.colorScheme) var colorScheme

    // UserDefaults key for tracking first launch
    private let hasLaunchedBeforeKey = "hasLaunchedBefore"

    // State variable to track sheet presentation
    @State private var showWhatsNewSheet = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(items) { section in
                        Section(section.name) {
                            ForEach(section.items) { item in
                                NavigationLink(value: item) {
                                    GrizzcoRow(item: item)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.1))
                    #if DEBUG
                    Section("Debug Tools") {
                        Toggle("Use Sponsor Test", isOn: $sponsorTest)
                            .listRowBackground(Color.white.opacity(0.1))
                    }
                    #endif
                }
                .scrollContentBackground(.hidden)
                .background(BackgroundGradient(colorScheme: colorScheme).customBackground)
                .navigationTitle("Employee Handbook")
                .navigationDestination(for: Item.self) { item in
                    GrizzcoDetail(item: item)
                }
            }
        }
        .sheet(isPresented: $showWhatsNewSheet) {
            whatsNewSheet()
        }
        .onAppear {
            // Check if it's the first launch and set the flag to show the "What's New" sheet
            if !UserDefaults.standard.bool(forKey: hasLaunchedBeforeKey) {
                UserDefaults.standard.set(true, forKey: hasLaunchedBeforeKey)
                showWhatsNewSheet = true
            }
        }
    }

    func whatsNewSheet() -> WhatsNewView {
        var features = [
            WhatsNew.Feature(
                image: .init(systemName: "text.book.closed.fill"),
                title: "Employee Handbook",
                subtitle: "Learn about the basics of being an Employee at Grizzco Industries"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "graduationcap.fill"),
                title: "Field Guide",
                subtitle: "Discover all there is to know about Salmonids and how to efficiently take them down!"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "clock.fill"),
                title: "Map Rotation",
                subtitle: "Find out the current Map Rotation for Salmon Run"
            ),
            WhatsNew.Feature(
                image: .init(systemName: "calendar"),
                title: "Map Schedule",
                subtitle: "See the upcoming Map Rotations for Salmon Run"
            )
        ]

        #if DEBUG
        features.append(
            WhatsNew.Feature(
                image: .init(systemName: "ladybug.fill"),
                title: "Debug",
                subtitle: "Enable Debug options by going to app settings in the iOS/iPadOS Settings app. Apps -> Grizzco Handbook -> Enable Debug"
            )
        )
        #endif

        let whatsNew = WhatsNew(
            version: "1.0.0",
            title: "Welcome to Grizzco Handbook",
            features: features
        )

        return WhatsNewView(whatsNew: whatsNew)
    }
}

#Preview {
    ContentView()
}
