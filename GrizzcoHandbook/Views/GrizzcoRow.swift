//
//  GrizzcoRow.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 16/6/2024.
//

import SwiftUI

struct GrizzcoRow: View {
    var item: Item
    
    var body: some View {
        if item.sponsored == "True" {
            HStack {
                if item.icon == "nil" {
                    EmptyView()
                } else {
                    Image(item.icon)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .frame(width: 50, height: 50)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("Sponsored")
                            .font(.caption)
                    }
                    Text(item.sponsoredDescription)
                        .font(.caption)
                }
                Spacer()
            }
        } else if item.sponsored == "False" {
            HStack {
                if item.icon == "nil" {
                    EmptyView()
                } else {
                    Image(item.icon)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .frame(width: 50, height: 50)
                }
                VStack(alignment: .leading) {
                    Text(item.displayedID)
                        .font(.headline)
                    Text(item.name)
                }
                Spacer()
            }
        }
    }
}

#if DEBUG
#Preview {
    GrizzcoRow(item: Item.example3)
}
#endif
