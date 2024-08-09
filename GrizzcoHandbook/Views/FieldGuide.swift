//
//  FieldGuide.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 15/6/2024.
//

import SwiftUI

struct FieldGuide: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var sponsorTest = false
    @State private var selectedSection: String? = nil
    private let lastVersionKey = "lastVersionKey"
    @State private var showWhatsNewSheet = false
    
    var items: [ItemSection] {
        if sponsorTest {
            return Bundle.main.decode([ItemSection].self, from: "FieldGuideSponsorTest.json")
        } else {
            return Bundle.main.decode([ItemSection].self, from: "FieldGuide.json")
        }
    }

    var filteredItems: [ItemSection] {
        let filteredSections: [ItemSection]

        if let selectedSection = selectedSection {
            filteredSections = items.filter { $0.name == selectedSection }
        } else {
            filteredSections = items
        }

        if searchText.isEmpty {
            return filteredSections
        } else {
            return filteredSections.map { section in
                ItemSection(
                    id: section.id,
                    name: section.name,
                    items: section.items.filter { item in
                        item.name.localizedCaseInsensitiveContains(searchText)
                    }
                )
            }.filter { !$0.items.isEmpty }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems) { section in
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
            .navigationTitle("Salmonid Field Guide")
            .navigationDestination(for: Item.self) { item in
                GrizzcoDetail(item: item)
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { selectedSection = nil }) {
                            Label("Show All", systemImage: selectedSection == nil ? "checkmark.circle" : "")
                        }
                        ForEach(items, id: \.name) { section in
                            Button(action: { selectedSection = section.name }) {
                                Label(section.name, systemImage: selectedSection == section.name ? "checkmark.circle" : "")
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showWhatsNewSheet) {
            WhatsNewSheet()
        }
        .onAppear {
            checkForNewVersion()
        }
    }

    // Function to check for a new app version
    func checkForNewVersion() {
        // Get the current app version
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"

        // Get the last version stored in UserDefaults
        let lastVersion = UserDefaults.standard.string(forKey: lastVersionKey)

        // Compare versions, if different show the "What's New" sheet
        if lastVersion == nil || currentVersion != lastVersion {
            showWhatsNewSheet = true
            UserDefaults.standard.set(currentVersion, forKey: lastVersionKey)
        }
    }
}

#Preview {
    FieldGuide()
}
