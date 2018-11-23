//
//  MovsTabbarViewController.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MovsTabbarViewController: UITabBarController {
    
    // MARK: - Properties
    
    private var moviesPresenter: MoviesPresentation?
    private var favoritesPresenter: FavoritesPresentation?
    private var itemTitles: [String] = ["Movies", "Favorites"]
    private var currentSelectedItemTitle: String = ""

    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let moviesView = MoviesRouter.assembleModule()
        moviesView.tabBarItem = UITabBarItem.init(title: self.itemTitles[0], image: UIImage(named: "list_icon"), selectedImage: UIImage(named: "list_icon"))
        
        let favoritesView = FavoritesRouter.assembleModule()
        favoritesView.tabBarItem = UITabBarItem.init(title: self.itemTitles[1], image: UIImage(named: "favorite_empty_icon"), selectedImage: UIImage(named: "favorite_empty_icon"))
        
        if let mv = moviesView as? MoviesView,
           let fv = favoritesView as? FavoritesView {
            self.moviesPresenter = mv.presenter
            self.favoritesPresenter = fv.presenter
        }
        
        self.viewControllers = [moviesView, favoritesView]
        
        self.selectedIndex = 0
        self.currentSelectedItemTitle = self.itemTitles[0]
        
    }
    
    // MARK: - Tabbar functions
    // TODO: - Make scroll to the top of view when the user taps in the icon of an already selected tab bar icon
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let title = item.title {
            if title == self.currentSelectedItemTitle {
                if title == "Movies" {
                    print("Should scroll movies collection view to top.")
                }
                if title == "Favorites" {
                    print("Should scroll favorites table view to top.")
                }
            } else {
                self.currentSelectedItemTitle = title
            }
        }
    }
    
    

}
