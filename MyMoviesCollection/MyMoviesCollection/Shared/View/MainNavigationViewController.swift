//
//  MainNavigationViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    // MARK: - Properties
    
    let mainTabBarViewController = MainTabBarViewController()
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Class Functions

    private func setUpNavigation() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = ColorSystem.cYellowDark
        navigationBar.tintColor = ColorSystem.cBlueDark
        view.backgroundColor = .white
    }
    
}
