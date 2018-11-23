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
    private var currentSelectedIndex: Int = 0

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
        
        self.selectedIndex = self.currentSelectedIndex
        
    }
    
    // MARK: - Tabbar functions
    // TODO: - Make scroll to the top of view when the user taps in the icon of an already selected tab bar icon
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if self.selectedIndex == self.currentSelectedIndex {
            if self.currentSelectedIndex == 0 {
                print("should scroll movies collection view to top")
            }
            if self.currentSelectedIndex == 1 {
                print("should scroll favorites table view to top")
            }
        } else {
            self.currentSelectedIndex = self.selectedIndex
        }
    }
    
    

}
