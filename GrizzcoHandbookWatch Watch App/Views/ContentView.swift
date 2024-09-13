//
//  ContentView.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 16/07/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var stageFetcher = StageFetcher()
    @State private var countdownText: String = ""

    var body: some View {
        VStack {
            if let setting = stageFetcher.currentSalmonRunSetting {
                VStack {
                    Text(setting.coopStage.name)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center) // Center-align and allow text to wrap
                        .padding(.bottom)
                    
                    GeometryReader { geometry in
                        if let stageImageURLString = setting.coopStage.image?.url, let stageImageURL = URL(string: stageImageURLString) {
                            HStack {
                                Spacer() // Add Spacer before the image
                                AsyncImage(url: stageImageURL) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.9)
                                        .cornerRadius(15)
                                } placeholder: {
                                    ProgressView()
                                }
                                Spacer()
                            }
                        }
                    }
                    CountdownView()
                }
            } else {
                Text("Loading...")
            }
        }
        .navigationTitle("Current Map")
        .onAppear {
            stageFetcher.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
