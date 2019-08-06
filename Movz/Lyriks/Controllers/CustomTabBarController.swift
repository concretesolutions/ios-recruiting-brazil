//
//  CustomTabBarController.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 31/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = Color.oldPaper
        self.tabBar.tintColor = Color.scarlet
        self.tabBar.unselectedItemTintColor = Color.black
       
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name:"Silentina Movie", size: 12) ?? UIFont.preferredFont(forTextStyle: .title1)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
       
        // Tab One
        let tabOne = ViewController()
        let navOne = UINavigationController(rootViewController: tabOne)
        configureNavBar(navController: navOne)
        let image = UIImage(named: "home")
        let tabOneBarItem = UITabBarItem(title: "Discover", image: image, selectedImage: image)
        navOne.tabBarItem = tabOneBarItem
       
        // Tab two
        let tabTwo = SearchViewController()
        let navTwo = UINavigationController(rootViewController: tabTwo)
         configureNavBar(navController: navTwo)
        let image2 = UIImage(named: "search")
        let tabTwoBarItem = UITabBarItem(title: "Search", image: image2, selectedImage: image2)
        navTwo.tabBarItem = tabTwoBarItem

        // Tab two
        let tabThree = FavoritesViewController()
        let navThree = UINavigationController(rootViewController: tabThree)
        configureNavBar(navController: navThree)
        let image3 = UIImage(named: "star")
        let tabThreeBarItem = UITabBarItem(title: "Favorite", image: image3, selectedImage: image3)
        navThree.tabBarItem = tabThreeBarItem

        self.viewControllers = [navOne,navTwo,navThree]
    
    }
    func configureNavBar(navController:UINavigationController){
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
        navController.view.backgroundColor = .clear
        navController.navigationItem.hidesBackButton = true
        navController.navigationItem.leftBarButtonItem = nil
    }
    

}
