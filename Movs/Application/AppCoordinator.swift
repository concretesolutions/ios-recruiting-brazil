//
//  AppCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Typealiases
    
    typealias Presenter = UIWindow
    typealias Controller = UINavigationController
    
    // MARK: - Properties
    
    internal let presenter: Presenter
    internal let coordinatedViewController: Controller
    private let homeCoordinator: HomeTabBarCoordinator
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.presenter = window
        self.coordinatedViewController = UINavigationController()
        self.homeCoordinator = HomeTabBarCoordinator(presenter: self.coordinatedViewController)
    }
    
    // MARK: - Coordination
    
    func start() {
        self.presenter.rootViewController = self.coordinatedViewController
        self.homeCoordinator.start()
        self.presenter.makeKeyAndVisible()
    }
}
