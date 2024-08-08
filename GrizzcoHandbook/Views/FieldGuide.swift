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
    
    var items: [ItemSection] {
        if sponsorTest {
            return Bundle.main.decode([ItemSection].self, from: "FieldGuideSponsorTest.json")
        } else {
            return Bundle.main.decode([ItemSection].self, from: "FieldGuide.json")
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
        }
    }
    
    var filteredItems: [ItemSection] {
        if searchText.isEmpty {
            return items
        } else {
            return items.map { section in
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
}

#Preview {
    FieldGuide()
}
