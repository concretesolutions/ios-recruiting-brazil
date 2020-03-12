//
//  MainTabBarViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        
    }

    // MARK: Class functions
    
    private func configView() {
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        let tabBar1 = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        vc1.tabBarItem = tabBar1
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .blue
        let tabBar2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        vc2.tabBarItem = tabBar2
        self.viewControllers = [vc1, vc2]
    }
    
}
