//
//  TabBarViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

class TabBarViewController: UITabBarController {
    private let willSelectViewController = PassthroughSubject<(current: UIViewController?, next: UIViewController?), Never>()
    public var publisher: AnyPublisher<(current: UIViewController?, next: UIViewController?), Never>
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // Erase publishers
        publisher = willSelectViewController.eraseToAnyPublisher()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create View Controllers
        let movieListViewController = UINavigationController(rootViewController: MovieListViewController())
        let favoriteListViewController = UINavigationController(rootViewController: FavoriteListViewController())
        
        // Set the View Controllers' tab items
        movieListViewController.tabBarItem = UITabBarItem(title: "Movies",
                                                          image: UIImage(systemName: "list.bullet"),
                                                          tag: 0)
        favoriteListViewController.tabBarItem = UITabBarItem(title: "Favorites",
                                                             image: UIImage(systemName: "heart.fill"),
                                                             tag: 1)
        
        // Set the Tab Bar Controller tab items        
        viewControllers = [movieListViewController, favoriteListViewController]
        
        self.delegate = self
    }
}

// MARK: - Delegate methods
extension TabBarViewController: UITabBarControllerDelegate {
    
    /// Called when tab bar item will be selected
    /// Send to publisher subscriptions current and next view controllers
    /// - Parameters:
    ///   - tabBarController: Tab bar controller
    ///   - viewController: Future visible view controller
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        var current: UIViewController!
        var next: UIViewController!
        
        if let navigationController = tabBarController.selectedViewController as? UINavigationController {
            current = navigationController.topViewController
        } else {
            current = tabBarController.selectedViewController
        }
        
        if let navigationController = viewController as? UINavigationController {
            next = navigationController.topViewController
        } else {
            next = viewController
        }
        
        willSelectViewController.send((current: current, next: next))
        
        return true
    }
}
