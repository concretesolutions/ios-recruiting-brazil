//
//  AppCoordinator.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private weak var rootController: AppRootController?

    // MARK: - Initializer

    public init(rootController: AppRootController?) {
        self.rootController = rootController
    }

    // MARK: - Functions

    func start() {
        let tabBarViewController = TabBarScreenFactory.makeTabBar()
        let navigationController = UINavigationController(rootViewController: tabBarViewController)

        rootController?.rootViewController = navigationController
    }
}
