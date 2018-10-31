//
//  TabController.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 31/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        let firstController = MainScreenViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: firstController)
        navigationController.tabBarItem.title = "Filmes"
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "list_icon")
        let secondController = FavoritesViewController(style: .plain)
        let secondNavigationController = UINavigationController(rootViewController: secondController)
        secondController.tabBarItem.title = "Favoritos"
        secondController.tabBarItem.image = #imageLiteral(resourceName: "favorite_empty_icon")
        
        tabBar.barTintColor = AppColors.mainYellow.color
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        
        let tabBarList = [navigationController, secondNavigationController]
        
        self.viewControllers = tabBarList
    }
}
