//
//  TabBarController.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let listVC = ListMoviesRouter.assembleModule()
        let favoriteVC = FavoriteMoviesRouter.assembleModule()
        
        listVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon")!, tag: 0)
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon")!, tag: 1)
        
        self.viewControllers = [listVC, favoriteVC]
    }

}
