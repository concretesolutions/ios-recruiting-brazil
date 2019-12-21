//
//  UITabBarController+RootViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UITabBarController: RootViewController {
    func add(viewController: UIViewController) {
        guard let controllerIndex = self.viewControllers?.firstIndex(of: viewController) else {
            self.addChild(viewController)
            let currentPosition = (self.viewControllers?.count ?? 1)
            self.viewControllers?.insert(viewController, at: 0)
            self.viewControllers?.remove(at: currentPosition)
            self.selectedIndex = 0
            return
        }
        self.selectedIndex = controllerIndex
    }
}
