//
//  TabBarControllerRepresentable.swift
//  GrizzcoHandbook
//
//  Created by Ben Lawrence on 02/07/2024.
//

import SwiftUI

struct TabBarControllerRepresentable: UIViewControllerRepresentable {
    @Environment(\.colorScheme) var colorScheme

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        let handbookViewController = UIHostingController(rootView: ContentView())
        handbookViewController.tabBarItem = UITabBarItem(title: "Handbook", image: UIImage(systemName: "text.book.closed.fill"), tag: 0)
        
        let fieldGuideViewController = UIHostingController(rootView: FieldGuide())
        fieldGuideViewController.tabBarItem = UITabBarItem(title: "Field Guide", image: UIImage(systemName: "graduationcap.fill"), tag: 1)
        
        let stageRotationViewController = UIHostingController(rootView: StageView())
        stageRotationViewController.tabBarItem = UITabBarItem(title: "Map Rotation", image: UIImage(systemName: "clock.fill"), tag: 2)
        
        let stageRotationScheduleViewController = UIHostingController(rootView: SalmonRunListView())
        stageRotationScheduleViewController.tabBarItem = UITabBarItem(title: "Map Schedule", image: UIImage(systemName: "calendar"), tag: 3)
        
        tabBarController.viewControllers = [handbookViewController, fieldGuideViewController, stageRotationViewController, stageRotationScheduleViewController]
        return tabBarController
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        if colorScheme == .dark {
            appearance.backgroundColor = UIColor.black
        } else {
            appearance.backgroundColor = UIColor(red: 247/255.0, green: 209/255.0, blue: 149/255.0, alpha: 1.0)
        }

        uiViewController.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            uiViewController.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
