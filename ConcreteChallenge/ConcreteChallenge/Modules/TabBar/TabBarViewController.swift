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
        
        self.tabBar.tintColor = .gray
        
        self.tabBar.barTintColor = #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
        UITabBar.appearance().clipsToBounds = true
        
        self.viewControllers = [PopularMoviesRouter.assembleModule(), FavoriteMoviesRouter.assembleModule()]
        self.selectedIndex = 0
    }
}
