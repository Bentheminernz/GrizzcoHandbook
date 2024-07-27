//
//  GrizzcoDetail.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 16/06/2024.
//

import SwiftUI

struct GrizzcoDetail: View {
    @Environment(\.colorScheme) var colorScheme
    let item: Item

    var body: some View {
        ScrollView {
            VStack {
                if item.image == "nil" {
                    EmptyView()
                } else {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                        .cornerRadius(25)
                        .shadow(radius: 7)
                }
                if item.imageCaption == "nil" {
                    EmptyView()
                } else {
                    Text(item.imageCaption)
                        .font(.caption)
                    Spacer()
                        .frame(height: 25)
                }
                VStack(alignment: .leading) {
                    ForEach(item.styledDescription()) { part in
                        Text(part.text)
                            .bold(part.isBold)
                            .padding(.bottom, 2)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity) // Ensure full width
        }
        .scrollContentBackground(.hidden)
        .background(
            colorScheme == .dark
                ? LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(hue: 0.096, saturation: 1.0, brightness: 1.0, opacity: 1.0), location: 0.116),
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
        .edgesIgnoringSafeArea([.leading, .trailing]) // Ignore only the horizontal safe areas
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Text {
    func bold(_ isBold: Bool) -> Text {
        isBold ? self.bold() : self
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        GrizzcoDetail(item: Item.example1)
    }
}
#endif
