//
//  HomeTabBarViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    // MARK: - UITabBarController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(named: "palettePurple")
    }
}
