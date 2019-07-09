//
//  TabBarController.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewControllers()
        self.setupVisual()
    }
    
    func setupViewControllers() {
        let popular = PopularMoviesViewController()
        popular.tabBarItem = UITabBarItem(title: "Movies", image: #imageLiteral(resourceName: "list_icon"), tag: 0)
        
        let favorites = FavoritesMoviesViewController()
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorite_empty_icon"), tag: 1)

        let tabBarViewControllers = [popular,
                                      favorites]
        
        self.viewControllers = tabBarViewControllers
    }
    
    func setupVisual() {
        self.tabBar.barTintColor = .yellow
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
