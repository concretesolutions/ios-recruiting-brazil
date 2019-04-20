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
        let viewC = MoviesViewController.instantiate()
        viewC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        viewC.coordinator = self
        navigationController.pushViewController(viewC, animated: true)
    }
    
    func startBookmarks() {
        navigationController.delegate = self
        let viewC = BookmarksViewController.instantiate()
        viewC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        viewC.coordinator = self
        navigationController.pushViewController(viewC, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {
                if coordinator === child {
                    childCoordinators.remove(at: index)
                    break
                }
        }
    }
}
