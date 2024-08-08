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
    static let cohozunaInfo = Item(id: "2.4.1", displayedID: "2.4.1", name: "Cohozuna", description: "Basic Information: Cohozuna is a King Salmonid of extraordinary size and strength, far larger than any other Salmonid encountered. Its bulky body is covered in thick scales, providing significant protection against ink-based attacks. Attack Behavior: Cohozuna has two primary attacks: it can leap into the air and slam down, creating a powerful shockwave that can instantly splat any Inkling caught directly underneath and deal substantial damage to those nearby. It can also perform a body slam by falling forward, crushing enemies in its path. Elimination: Defeating Cohozuna requires a coordinated team effort. While shooting ink at Cohozuna will deal damage, the most effective method is using Golden Eggs fired from egg cannons, which deal significant damage. Despite its sluggish movement, Cohozuna has immense health, so continuous attacks with main weapons and Golden Eggs are essential to defeat it within the time limit. Supporting Information: Cohozuna is an elite leader among Salmonids, recognized by its distinctive red and gray scales, chains around its neck, and menacing mohawk. Its health is known to fluctuate, so make sure you never slack off! Always give it your A Game! Cohozuna’s presence can disrupt the battlefield by blocking access to Golden Eggs and trapping workers. Its predictable but deadly attacks require vigilance and teamwork to bring it down. Successfully damaging Cohozuna rewards you with fish scales, a valulable resource used to purchase cool gear and accessories.", image: "Cohozuna", imageCaption: "Cohozuna", icon: "CohozunaIcon", sponsored: "False", sponsoredDescription: "nil")
    static let horrorborosInfo = Item(id: "2.4.2", displayedID: "2.4.2", name: "Horrorboros", description: "Basic Information: Horrorboros is a large, dragon-like King Salmonid with distinct yellow eyes, crooked teeth, and a bomb device similar to Steelheads. It has a serpentine body with rows of lights and wires attached to its head. Attack Behavior: Horrorboros floats around the map, charging a Booyah Bomb-like blast in its mouth. You can attack this bomb until it bursts, dealing substantial damage to Horrorboros and canceling its attack. Elimination: Employees should focus on attacking the bomb in Horrorboros’ mouth, as bursting it deals massive damage. Golden Eggs and main weapons should target the bomb for efficiency. Continuous pressure is vital due to its large health pool. Supporting Information: Horrorboros’ size and floating nature make it vulnerable to attacks from anywhere on the map. Utilizing its bomb is crucial for a swift defeat. You must work together, using special weapons and Golden Eggs strategically to maximize damage and overcome this formidable foe.", image: "Horrorboros", imageCaption: "Horrorboros", icon: "HorrorborosIcon", sponsored: "False", sponsoredDescription: "nil")
    static let megalodontiaInfo = Item(id: "2.4.3", displayedID: "2.4.3", name: "Megalodontia", description: "Basic Information: Megalodontia is an enormous King Salmonid, large enough to swallow a ship whole. It has white bulging eyes, blue hair, and a jaw contraption resembling braces. Its back features various nets and a large red bump with bandages. Attack Behavior: Megalodontia submerges and targets a random worker, marked by a large circle. After a short time, it emerges, swallowing anything in the circle, including other Salmonids, who drop Golden Eggs upon death. Elimination: To defeat Megalodontia, you must attack the large bump on its back, which takes extra damage. Coordinated attacks with main weapons and Golden Eggs are essential due to its immense health. Positioning near the weak point before each attack is crucial. Supporting Information: Megalodontia is an elite leader among Salmonids, known for its colossal size and destructive power. Its attacks can clear out other Salmonids, providing strategic advantages. Workers need to stay alert and use its predictable attack patterns to their benefit while focusing on its weak point for maximum damage.", image: "Megalodontia", imageCaption: "Megalodontia", icon: "MegalodontiaIcon", sponsored: "False", sponsoredDescription: "nil")
    static let triumvirateInfo = Item(id: "2.4.4", displayedID: "2.4.4", name: "Triumvirate", description: "Basic Information: The Triumvirate is a high-stakes boss encounter where the formidable trio of King Salmonids—Cohozuna, Megalodontia, and Horrorboros—assault together. Each King Salmonid appears separately on the battlefield, and all must be taken down to complete the wave. This encounter challenges you to manage and defeat multiple powerful enemies simultaneously. Attack Behavior: Each King Salmonid will engage in its usual attack patterns, but their combined presence makes the battle particularly chaotic. Megalodontia’s massive size and attacks can impact the other King Salmonids, while Horrorboros’ explosive devices affect nearby enemies. Coordinating your efforts is crucial to handle their diverse threats. Elimination: To overcome the Triumvirate, focus on using your available weapons and specials to deal substantial damage to each King Salmonid. Managing their attacks and leveraging the opportunities created by their interactions will be key to clearing this intense challenge. Supporting Information: The Triumvirate showcases the synergy of King Salmonids working together in a coordinated assault. Each King Salmonid brings its unique abilities and attacks to the fray, requiring strategic planning and teamwork. Efficient use of rare weapons and special charges is essential for overcoming this formidable group of adversaries.", image: "Triumvirate", imageCaption: "Triumvirate", icon: "TriumvirateIcon", sponsored: "False", sponsoredDescription: "nil")
    
    
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

struct BackgroundGradient {
    var colorScheme: ColorScheme

    var customBackground: LinearGradient {
        return colorScheme == .dark
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
    }
}
