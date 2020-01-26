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
        self.view.backgroundColor = .red
        dao.cellWidth = self.view.bounds.width/3
        setUpBar()
        
    }

    private func setUpBar(){
        
        //MoviesViewController
        let listView = ListViewController()
        let moviesBar = UINavigationController(rootViewController: listView)
        moviesBar.tabBarItem.image = UIImage(named: "")
        moviesBar.tabBarItem.selectedImage = UIImage(named: "")
        
        //FavoritesViewController
        let fav = FavoritesViewController()
        let favoritesBar = UINavigationController(rootViewController: fav)
        fav.listView = listView
        favoritesBar.tabBarItem.image = UIImage(named: "")
        favoritesBar.tabBarItem.selectedImage = UIImage(named: "")
        //add to bar
        
        viewControllers = [moviesBar,favoritesBar]
        
    }
    
    
}

