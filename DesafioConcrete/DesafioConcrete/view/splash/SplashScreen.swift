//
//  SplashScreen.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }
    
    @objc func splashTimeOut(sender : Timer){
        let popularView = PopularView(nibName: "PopularView", bundle: nil)
        let favoritosView = FavoritosView(nibName: "FavoritosView", bundle: nil)
        
        let nav1 = MyNavigationController()
        let nav2 = MyNavigationController()
        
        nav1.pushViewController(popularView, animated: false)
        nav2.pushViewController(favoritosView, animated: false)
        
        let tabBarController = MyTabBarController()
        
        tabBarController.viewControllers = [nav1, nav2]
//        nav1.tabBarItem.title = "Populares"
        nav1.tabBarItem.image = UIImage(named: "list_icon.png")
//        nav2.tabBarItem.title = "Favoritos"
        nav2.tabBarItem.image = UIImage(named: "favorite_empty_icon.png")
        
        AppDelegate.sharedInstance().window?.rootViewController = tabBarController
    }

}
