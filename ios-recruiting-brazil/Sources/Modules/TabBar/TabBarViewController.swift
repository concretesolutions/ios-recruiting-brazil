//
//  ViewController.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 28/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popularGrid = PopularMoviesGridController.loadFromStoryboard()
        popularGrid.prepareForShow(viewModel: PopularMoviesGridViewModel(service: PupolarMoviesGridService()))
        let favorite = FavoriteMoviesListController.loadFromStoryboard()
        favorite.prepareForShow(viewModel: FavoriteMoveisListViewModel(service: FavoriteMoviesListService()))
        
        popularGrid.tabBarItem = UITabBarItem(title: "Movies",
                                              image: UIImage(named: "list_icon"),
                                              tag: 0)
        favorite.tabBarItem = UITabBarItem(title: "Favorites",
                                           image: UIImage(named: "favorite_empty_icon"),
                                           tag: 1)
        
        let controllers = [popularGrid, favorite]
        self.viewControllers = controllers
        self.viewControllers = controllers.map {
            let navigation = UINavigationController(rootViewController: $0)
            navigation.setupDefaultNavBar()
            return navigation
        }
    }
}
