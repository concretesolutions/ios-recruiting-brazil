//
//  FavoriteMovsCoordinator.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 21/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule
import FavoriteMovsFeature

class FavoriteMovsCoordinator: BaseCoordinator {
    var homeFavoriteMovsRouter: HomeFavoriteMovsRouter?
    var navigationController: UINavigationController!
    override init(){
        super.init()
    }
}

extension FavoriteMovsCoordinator: CoordinatorType {
    func start() {
        self.setupCurrentView()
    }
    
    func currentViewController() -> UIViewController {
        return super.currentViewController
    }
}


//MARK: - Setups
extension FavoriteMovsCoordinator {
    
    private func setupCurrentView() {
        self.navigationController = UINavigationController()
        
        
        // HomeViewController
        self.homeFavoriteMovsRouter = HomeFavoriteMovsRouter()
        let homeFavoriteMovsViewControler = self.homeFavoriteMovsRouter!.makeUI()
        homeFavoriteMovsViewControler.tabBarItem = UITabBarItem(title: "Favorite", image: Assets.TabBarItems.favoriteEmpty, tag: 1)
        
        // Current View
        self.navigationController.pushViewController(homeFavoriteMovsViewControler, animated: true)
        super.currentViewController = self.navigationController
    }
}
