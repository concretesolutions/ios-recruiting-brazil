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
            moviesGridCounter += 1
            if moviesGridCounter >= 2 {
                moviesGridNC.popularMoviesVC.popularMoviesView.collectionView.setContentOffset(.zero, animated: true)
            }
            
            favoritesCounter = 0
            
        case favoritesNC.tabBarItem:
            favoritesCounter += 1
            if favoritesCounter >= 2 {
                favoritesNC.favoriteMoviesVC.favoriteView.tableView.setContentOffset(.zero, animated: true)
            }
            
            moviesGridCounter = 0
            
        default:
            do { /* Nothing */ }
        }
    }
    
    // Private Types
    // Private Properties
    
    private var moviesGridCounter = 1
    private var favoritesCounter = 0
    
    private let moviesGridNC = MoviesGridNavigationController()
    private let favoritesNC = FavoritesNavigationController()
    
    // Private Methods
    
    private func initController() {
        view.tintColor = .mvYellow
        viewControllers = [moviesGridNC, favoritesNC]
    }
}
