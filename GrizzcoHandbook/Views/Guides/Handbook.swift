//
//  ContentView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 15/6/2024.
//

import SwiftUI
import WhatsNewKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var selectedSection: String? = nil

    var items: [ItemSection] {
        return Bundle.main.decode([ItemSection].self, from: "handbook.json")
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
            VStack {
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
                }
                .scrollContentBackground(.hidden)
                .background(BackgroundGradient(colorScheme: colorScheme).customBackground)
                .navigationTitle("Employee Handbook")
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
        }
    }
}

#Preview {
    ContentView()
}
