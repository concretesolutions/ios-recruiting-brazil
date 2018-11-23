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

    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let moviesView = MoviesRouter.assembleModule()
        let favoritesView = FavoritesRouter.assembleModule()
        
        if let mv = moviesView as? MoviesView,
           let fv = favoritesView as? FavoritesView {
            self.moviesPresenter = mv.presenter
            self.favoritesPresenter = fv.presenter
        }
        
        self.viewControllers = [moviesView, favoritesView]
        
        self.selectedIndex = 0
        
    }
    
    // MARK: - Tabbar functions
    // TODO: - Make scroll to the top of view when the user taps in the icon of an already selected tab bar icon
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }

}
