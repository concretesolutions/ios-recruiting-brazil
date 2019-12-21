//
//  GenericNavigationCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class GenericNavigationCoordinator<ChildType: InitializableCoordinator>: Coordinator {

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

    private let childCoordinatorType: ChildType.Type
    private lazy var childCoordinator = ChildType(rootViewController: self.rootViewController)
    
    init(rootViewController: RootViewController, childType: ChildType.Type) {
        self.parentRootViewController = rootViewController
        self.childCoordinatorType = childType
    }

    func start(previousController: UIViewController? = nil) {
        self.parentRootViewController.add(viewController: rootViewController)

        childCoordinator.start(previousController: rootViewController)
    }
}
