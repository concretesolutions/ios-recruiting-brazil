//
//  UINavigationController+CustomAppearance.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

extension UINavigationController {
    convenience init(rootVC: UIViewController, color: UIColor) {
        self.init(rootViewController: rootVC)
        navigationBar.barTintColor = color
    }
}

extension UITabBarController {
    convenience init(color: UIColor) {
        self.init()
        tabBar.barTintColor = color
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        UITabBar.appearance()
    }
}
