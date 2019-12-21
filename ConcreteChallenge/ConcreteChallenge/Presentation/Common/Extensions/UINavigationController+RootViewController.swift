//
//  UINavigationController+RootViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UINavigationController: RootViewController {
    func add(viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
}
