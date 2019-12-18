//
//  TabBarController.swift
//  DesafioConcrete
//
//  Created by Kacio Henrique Couto Batista on 05/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let movieControllerGrid = UINavigationController(rootViewController: MoviesGridController())
     let favoriteMovieController = UINavigationController(rootViewController: FavoriteMoviesController())
    override func viewDidLoad() {
        super.viewDidLoad()
        movieControllerGrid.tabBarItem =
            UITabBarItem(title: "Movies", image: #imageLiteral(resourceName: "list_icon"), selectedImage: #imageLiteral(resourceName: "list_icon"))
        movieControllerGrid.navigationBar.barStyle = .black

        favoriteMovieController.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage: #imageLiteral(resourceName: "favorite_empty_icon"))
        favoriteMovieController.navigationBar.barStyle = .default
        self.viewControllers = [movieControllerGrid,favoriteMovieController]
        
    }
   
}
