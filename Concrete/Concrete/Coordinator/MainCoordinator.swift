//
//  MainCoordinator.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        navigationController.navigationBar.barTintColor = UIColor(rgb: Const.mainColor)
        navigationController.navigationBar.tintColor = .black

        let viewC = MoviesViewController.instantiate()
        viewC.tabBarItem = UITabBarItem(title: "mainCoordinatorTabMovies".localized(),
                                        image: UIImage.init(named: "list_icon"), tag: 0)
        viewC.coordinator = self
        navigationController.pushViewController(viewC, animated: true)
    }

    func startBookmarks() {
        navigationController.delegate = self
        navigationController.navigationBar.barTintColor = UIColor(rgb: Const.mainColor)
        navigationController.navigationBar.tintColor = .black

        let viewC = BookmarksViewController.instantiate()
        viewC.tabBarItem = UITabBarItem(title: "mainCoordinatorTabFavorites".localized(),
                                        image: UIImage.init(named: "favorite_gray_icon"), tag: 0)
        viewC.coordinator = self
        navigationController.pushViewController(viewC, animated: true)
    }

    func createDetails(to viewModel: MovieViewModel) {
        let viewC = DetailsViewController.instantiate()
        viewC.coordinator = self
        viewC.viewModel = viewModel
        navigationController.pushViewController(viewC, animated: true)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() where coordinator === child {
                childCoordinators.remove(at: index)
                break
        }
    }
}
