//
//  TabBarViewController.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SetUp functions
    private func setUpItems() {
        
        self.tabBar.tintColor = UIColor(red: 241.0/255.0, green: 186.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        
        self.tabBar.barTintColor = UIColor.white
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        
        self.viewControllers = []
        self.selectedIndex = 1
    }
    
}
