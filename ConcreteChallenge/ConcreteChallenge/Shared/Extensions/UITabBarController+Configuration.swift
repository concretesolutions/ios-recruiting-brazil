//
//  UITabBarController+Configuration.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 18/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

extension UITabBarController {
    func setupStyle() {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor(named: "movs-yellow")
        tabBar.barTintColor = UIColor(named: "movs-yellow")
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .darkGray
    }
}
