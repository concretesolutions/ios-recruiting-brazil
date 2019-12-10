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
    
    internal let dependencies = Dependencies()
    internal let presenter: Presenter
    internal let coordinatedViewController: Controller
    private var homeCoordinator: HomeTabBarCoordinator!
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.presenter = window
        self.coordinatedViewController = UINavigationController()
        self.homeCoordinator = HomeTabBarCoordinator(parent: self)
    }
    
    // MARK: - Coordination
    
    func start() {
        self.presenter.rootViewController = self.coordinatedViewController
        self.homeCoordinator.start()
        self.presenter.makeKeyAndVisible()
    }
    
    func finish() {
        self.presenter.rootViewController = nil
        self.homeCoordinator.finish()
        self.homeCoordinator = nil
        self.presenter.resignKey()
    }
}
