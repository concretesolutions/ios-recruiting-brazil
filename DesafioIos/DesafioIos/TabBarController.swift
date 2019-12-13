//
//  TabBarController.swift
//  DesafioConcrete
//
//  Created by Kacio Henrique Couto Batista on 05/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movieController = UINavigationController(rootViewController: MoviesController())
        movieController.tabBarItem =
            UITabBarItem(title: "Movies", image: #imageLiteral(resourceName: "list_icon"), selectedImage: #imageLiteral(resourceName: "list_icon"))
        let favoriteMovieController = UINavigationController(rootViewController: FavoriteMoviesController())
        favoriteMovieController.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage: #imageLiteral(resourceName: "favorite_empty_icon"))
        self.viewControllers = [movieController,favoriteMovieController]
        
    }
}
