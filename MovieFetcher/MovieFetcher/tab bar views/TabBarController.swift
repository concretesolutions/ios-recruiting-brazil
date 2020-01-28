//
//  ViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .clear
        dao.cellWidth = self.view.bounds.width/3
        setUpBar()
    }
    
    
    //MARK: - Complimentary methods
    private func setUpBar(){

        //MoviesViewController
        let listView = ListViewController()
        listView.title = "Movies"
        let moviesBar = UINavigationController(rootViewController: listView)
        moviesBar.title = "Movies"
        moviesBar.tabBarItem.image = UIImage(named: "list_icon")
        moviesBar.tabBarItem.selectedImage = UIImage(named: "list_icon")
        //FavoritesViewController
        let fav = FavoritesViewController()
        fav.title = "Favorites"
        let favoritesBar = UINavigationController(rootViewController: fav)
        fav.listView = listView
        favoritesBar.title = "Favorites"
        favoritesBar.tabBarItem.image = UIImage(named: "favorite_empty_icon")
        favoritesBar.tabBarItem.selectedImage = UIImage(named: "favorite_empty_icon")
        //add to bar
        
        viewControllers = [moviesBar,favoritesBar]
        
    }
    
    
}

