//
//  ViewController.swift
//  Movs
//
//  Created by Pedro Clericuzi on 19/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("1acfc0448d3bf8484d2d861912457314", forKey: "apiKey") //UserDefaults to save apiKey the of themoviedb
        self.navBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar()
    }
    
    /*override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items)?[0]{
            self.navigationItem.rightBarButtonItem = nil
        }
        else if item == (self.tabBar.items)?[1]{
            self.filterIcon()
        }
    }*/
    
    func navBar() {
        navigationItem.title = "Movies"
        UINavigationBar.appearance().barTintColor = UIColor( red: CGFloat(217/255.0), green: CGFloat(151/255.0), blue: CGFloat(30/255.0), alpha: CGFloat(0.8) )
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        
    }
    
    //Mathod to draw the TabBar
    func tabBar() {
        let movieView = MovieView()
        movieView.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon.png"), selectedImage: nil)
        let favView = FavoriteView()
        favView.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon.png"), selectedImage: nil)
        
        viewControllers = [movieView, favView]
        tabBar.barTintColor = UIColor( red: CGFloat(247/255.0), green: CGFloat(206/255.0), blue: CGFloat(91/255.0), alpha: CGFloat(0.8) )
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}

