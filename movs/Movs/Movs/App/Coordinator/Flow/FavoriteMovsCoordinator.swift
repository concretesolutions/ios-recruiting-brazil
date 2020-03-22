//
//  FavoriteMovsCoordinator.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 21/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule
class FavoriteMovsCoordinator: BaseCoordinator {
    
}

extension FavoriteMovsCoordinator: CoordinatorType {
    func start() {
        print("uhull start FavoriteMovsCoordinator")
    }
    
    func pop() {
        
    }
    
    func currentViewController() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .blue
        view.tabBarItem = UITabBarItem(title: "Favorite", image: Assets.TabBarItems.favoriteEmpty, tag: 1)
        return view
    }
}
