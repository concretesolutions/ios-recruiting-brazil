//
//  AppCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// The coordinator of the root view controller
class AppCoordinator: Coordinator {
    lazy var rootViewController: RootViewController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = UIColor.appLightPurple
        tabBarController.tabBar.tintColor = UIColor.appExtraLightRed
        tabBarController.tabBar.barStyle = .black
    
        return tabBarController
    }()

    private lazy var firstTabCoordinator = GenericNavigationCoordinator(
        rootViewController: rootViewController,
        childCoordinator: PopularMoviesCoordinator(rootViewController: rootViewController,
                                                   viewModelsFactory: self.viewModelsFactory,
                                                   atributtes: ("Popular", .custom("Home", "home")))
    )
    
    private lazy var secondTabCoordinator = GenericNavigationCoordinator(
        rootViewController: rootViewController,
        childCoordinator: PopularMoviesCoordinator(rootViewController: rootViewController,
                                                   viewModelsFactory: FavoriteViewModelsFactory(),
                                                   atributtes: ("Favorites", .system(.favorites)))
    )
    
    private let viewModelsFactory: ViewModelsFactory
    
    init(viewModelsFactory: ViewModelsFactory) {
        self.viewModelsFactory = viewModelsFactory
    }
    
    func start(previousController: UIViewController? = nil) {
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }

        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        secondTabCoordinator.start()
        firstTabCoordinator.start()
    }
}
