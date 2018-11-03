//
//  AppCoordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 24/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let tabBarController = MovsTabBarController()
    
    var data: Any?
    var onCoordinatorStarted: OnCoordinatorStarted?
    
    var childs:[Coordinator] = []
    
    func start() {
        
        let moviesCoordinator = MoviesGridCoordinator()
        
        moviesCoordinator.onCoordinatorStarted = { [unowned self] vc in
            self.tabBarController
                .moviesNavigationController
                .pushViewController(vc, animated: true)
        }
        moviesCoordinator.start()
        
        self.childs.append(moviesCoordinator)
        
        let favoritesCoordinator = FavoriteMoviesCoordinator()
        
        favoritesCoordinator.onCoordinatorStarted = { [unowned self] vc in
            self.tabBarController
                .favoritesNavigationController
                .pushViewController(vc, animated: true)
        }
        favoritesCoordinator.start()
        
        self.childs.append(favoritesCoordinator)
        
        self.onCoordinatorStarted?(self.tabBarController)
    }
}
