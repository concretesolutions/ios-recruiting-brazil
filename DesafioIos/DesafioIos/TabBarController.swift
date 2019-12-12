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
        let movieController = MoviesController()
        movieController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
              let favoriteMovieController = FavoriteMoviesController()
              favoriteMovieController.tabBarItem =  UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
              self.viewControllers = [movieController,favoriteMovieController]
    }
}
