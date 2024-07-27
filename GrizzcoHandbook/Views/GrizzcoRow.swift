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
                Text(item.id)
                    .font(.headline)
                Text(item.name)
            }
            Spacer()
        }
    }
}

#if DEBUG
#Preview {
    GrizzcoRow(item: Item.example1)
}
#endif
