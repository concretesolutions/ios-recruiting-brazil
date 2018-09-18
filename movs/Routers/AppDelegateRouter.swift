//
//  AppDelegateRouter.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

struct AppDelegateRouter {
    static func addHomeFlow() -> UIViewController {
        let navigationController: UINavigationController = StoryboadsUtil.Movies.main.instantiateInitialViewController() as! UINavigationController
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "list_icon").withRenderingMode(.alwaysOriginal)
        navigationController.title = "Movies"
        return navigationController
    }
    
    static func addFavoriteFlow() -> UIViewController {
        let navigationController: UINavigationController = StoryboadsUtil.Favorite.main.instantiateInitialViewController() as! UINavigationController
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "favorite_empty_icon").withRenderingMode(.alwaysOriginal)
        navigationController.title = "Favorites"
        return navigationController
    }
}
