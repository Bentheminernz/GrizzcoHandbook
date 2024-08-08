//
//  Model.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 16/6/2024.
//

import Foundation
import SwiftUI

struct DescriptionPart: Identifiable {
    let id = UUID()
    let text: String
    let isBold: Bool
}

struct ItemSection: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var items: [Item]
}

struct Item: Identifiable, Codable, Hashable {
    var id: String
    var displayedID: String
    var name: String
    var description: String
    var image: String
    var imageCaption: String
    var icon: String
    var sponsored: String
    var sponsoredDescription: String
    
    #if DEBUG
    static let example1 = Item(id: "1.1.0", displayedID: "1.1.0", name: "To All My Happy Little Workers", description: "Here at Grizzco Industries, we aim to create a richer, better way of life for everyone in our society through daily collection of Power Eggs. We're looking for dedicated, eager workers to assist us as we move forward toward a brighter future. Could that be you?\n\nCollecting Power Eggs can indeed be a risky business, but when standing shoulder to shoulder in the thick of the action alongside coworkers united under the same vision you may see yourself in a different light—an innovator, a change-bringer, one who rises to all challenges.\n\nNaturally, you will be well rewarded for your efforts. We offer an attractive and competitive remuneration package to all our employees.", image: "nil", imageCaption: "nil", icon: "nil", sponsored: "False", sponsoredDescription: "nil")
    static let example2 = Item(id: "2.1.1", displayedID: "2.1.1", name: "Chum, Smallfry and Cohock", description: "Basic Information: They tend to appear in groups rather than alone. Defeating them will earn you Power Eggs. Attack Behavior: They use their sense of smell to locate and close in on targets who have entered their territory. Once they close in on a target, they perform close-range attacks using frying pans or other cookware. Elimination: Can be neutralized relatively easily with a direct hit of ink. Supporting Information: They inhabit a restricted ocean zone, and any unauthorized contact with them is expressly forbidden by law. The Smallfry might be weak, but they're very fast. They often ambush their targets from below. The larger Cohock moves slowly but packs a real punch with direct, strong attacks. On their own, they don't pose a significant threat, but ignore them and you may quickly find yourself surrounded.", image: "SmallfryChumCohock", imageCaption: "Small Fry, Chum, Cohock", icon: "SnatcherIcon", sponsored: "False", sponsoredDescription: "nil")
    static let example3 = Item(id: "1.1.7", displayedID: "nil", name: "Travvl", description: "nil", image: "nil", imageCaption: "nil", icon: "Travvl", sponsored: "True", sponsoredDescription: "Download Travvl Today! The ultimate travel companion.")
    #endif
    
    
    func styledDescription() -> [DescriptionPart] {
        let keywords = ["Basic Information:", "Attack Behavior:", "Elimination:", "Supporting Information:", "Low Tide:", "High Tide:", "What Happens:"]
        let keywords2 = ["Advice from Mr. Grizz:", "Supplementary Information:", "How to Get Golden Eggs:"]
        let allKeywords = keywords + keywords2
        
        var parts: [DescriptionPart] = []
        var remainingDescription = description
        
        while !remainingDescription.isEmpty {
            var found = false
            
            for keyword in allKeywords {
                if let range = remainingDescription.range(of: keyword, options: .caseInsensitive) {
                    // Text before keyword, preserving leading newlines
                    let beforeKeyword = remainingDescription[..<range.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                    if !beforeKeyword.isEmpty {
                        parts.append(DescriptionPart(text: String(beforeKeyword), isBold: false))
                    }
                    
                    // Keyword (bold)
                    parts.append(DescriptionPart(text: keyword, isBold: true))
                    
                    // Move past the keyword in remainingDescription
                    remainingDescription = String(remainingDescription[range.upperBound...])
                    found = true
                    break // Exit the loop after finding the first match
                }
            }
            
            if !found {
                // No keyword found, add remainingDescription as non-bolded text
                parts.append(DescriptionPart(text: remainingDescription, isBold: false))
                remainingDescription = "" // Clear remainingDescription as we're done
            }
        }
        
        return parts
    }

}
