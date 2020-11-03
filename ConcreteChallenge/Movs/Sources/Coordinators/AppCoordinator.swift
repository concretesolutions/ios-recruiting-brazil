//
//  AppCoordinator.swift
//  Movs
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private weak var rootController: AppRootController?

    // MARK: - Private variables

    private var childCoordinator: [Coordinator] = []

    // MARK: - Initializer

    public init(rootController: AppRootController?) {
        self.rootController = rootController
    }

    // MARK: - Coodinator conforms

    func start() {
        let moviesCoordinator = TabBarCoordinator(rootController: rootController)
        childCoordinator.append(moviesCoordinator)
        moviesCoordinator.start()
    }
}
