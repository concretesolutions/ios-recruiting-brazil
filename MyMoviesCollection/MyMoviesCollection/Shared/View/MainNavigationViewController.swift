//
//  MainNavigationViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    let mainTabBarViewController = MainTabBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setUpNavigation() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = ColorSystem.cYellowDark
        navigationBar.tintColor = ColorSystem.cBlueDark
        view.backgroundColor = .white
    }
    
}
