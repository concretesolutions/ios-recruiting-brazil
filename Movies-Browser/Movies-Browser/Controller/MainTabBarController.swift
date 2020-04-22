//
//  AppTabBarController.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Variables
    var coordinator: MainTabBarCoordinator?
}

// MARK: - Events -
extension MainTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarStyle()
    }
}

// MARK - UI Style -
extension MainTabBarController {
    private func setupTabBarStyle(){
        self.tabBar.tintColor = .systemPink
    }
}
