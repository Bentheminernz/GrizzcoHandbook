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
            .background(
                colorScheme == .dark
                    ? LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color(hue: 0.096, saturation: 1.0, brightness: 1.0, opacity: 1.0), location: 0.115),
                        Gradient.Stop(color: Color(hue: 0.096, saturation: 0.699, brightness: 1.0, opacity: 1.0), location: 0.286),
                        Gradient.Stop(color: Color(hue: 0.15, saturation: 0.0, brightness: 0.0, opacity: 1.0), location: 1.0),
                        Gradient.Stop(color: Color(hue: 0.552, saturation: 1.0, brightness: 1.0, opacity: 0.0), location: 1.0)
                    ]), startPoint: .top, endPoint: .bottom)
                    : LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color(hue: 0.097, saturation: 1.0, brightness: 1.0, opacity: 1.0), location: 0.0),
                        Gradient.Stop(color: Color(hue: 0.096, saturation: 0.496, brightness: 0.957, opacity: 1.0), location: 0.351),
                        Gradient.Stop(color: Color(hue: 0.097, saturation: 0.452, brightness: 1.0, opacity: 1.0), location: 1.0)
                    ]), startPoint: .top, endPoint: .bottom)
            )
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
