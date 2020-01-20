//
//  MainTabBarController.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 12/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    // Override Methods
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item {
        case moviesGridNC.tabBarItem:
            if moviesGridNC.popularMoviesVC.view.window != nil {
                moviesGridNC.popularMoviesVC.popularMoviesView.collectionView.setContentOffset(.zero, animated: true)
            }
            
        case favoritesNC.tabBarItem:
            if favoritesNC.favoriteMoviesVC.view.window != nil {
                favoritesNC.favoriteMoviesVC.favoriteView.tableView.setContentOffset(.zero, animated: true)
            }
            
        default:
            do { /* Nothing */ }
        }
    }
    
    // Private Types
    // Private Properties
    
    private let moviesGridNC = MoviesGridNavigationController()
    private let favoritesNC = FavoritesNavigationController()
    
    // Private Methods
    
    private func initController() {
        view.tintColor = .mvYellow
        viewControllers = [moviesGridNC, favoritesNC]
    }
}
