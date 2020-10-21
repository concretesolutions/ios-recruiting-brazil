//
//  TabViewController.swift
//  app
//
//  Created by rfl3 on 15/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {

        // Instatialize controllers
        let gridController = GridViewController()
        let favsController = FavsViewController()

        // Set tabBar items
        gridController.tabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(systemName: "square.grid.2x2"),
                                                 tag: 0)
        gridController.tabBarItem.selectedImage = UIImage(systemName: "square.grid.2x2.fill")

        favsController.tabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(systemName: "heart"),
                                                 tag: 1)
        favsController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")

        // Add items to tabBar
        self.viewControllers = [gridController, favsController]

        self.setupLayout()

    }

    func setupLayout() {

        self.tabBar.barTintColor = UIColor(named: "orange")
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .white

    }
    
}
