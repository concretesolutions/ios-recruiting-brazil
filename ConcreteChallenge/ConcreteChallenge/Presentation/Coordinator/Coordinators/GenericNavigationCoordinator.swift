//
//  GenericNavigationCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class GenericNavigationCoordinator: Coordinator {

    var parentRootViewController: RootViewController

    var rootViewController: RootViewController = {
        let navigationViewController = UINavigationController()

        navigationViewController.navigationBar.isTranslucent = false
        navigationViewController.navigationBar.barTintColor = UIColor.appLightPurple
        navigationViewController.navigationBar.prefersLargeTitles = true
        navigationViewController.navigationBar.tintColor = UIColor.white
        navigationViewController.navigationBar.barStyle = .black

        return navigationViewController
    }()

    private var childCoordinator: Coordinator
    
    init(rootViewController: RootViewController, childCoordinator: Coordinator) {
        self.parentRootViewController = rootViewController
        self.childCoordinator = childCoordinator
        
        childCoordinator.rootViewController = self.rootViewController
    }

    func start(previousController: UIViewController? = nil) {
        self.parentRootViewController.add(viewController: rootViewController)

        childCoordinator.start(previousController: rootViewController)
    }
}
