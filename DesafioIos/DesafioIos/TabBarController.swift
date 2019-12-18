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
        changeTabBarAppearance()
        movieControllerGrid.tabBarItem =
            UITabBarItem(title: "Movies", image: #imageLiteral(resourceName: "list_icon"), selectedImage: #imageLiteral(resourceName: "list_icon"))
        movieControllerGrid.navigationBar.barStyle = .black

        favoriteMovieController.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage: #imageLiteral(resourceName: "favorite_full_icon"))
        favoriteMovieController.navigationBar.barStyle = .black
        self.viewControllers = [movieControllerGrid,favoriteMovieController]

    }
    func changeTabBarAppearance(){
        self.tabBar.barTintColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0.8823153377, green: 0.7413565516, blue: 0.3461299241, alpha: 1)
    }
}
