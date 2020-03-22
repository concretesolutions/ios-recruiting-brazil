//
//  CreatorMyTabbar.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 21/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

class MyTabBarCreator {
    init() {}
    
    func makeUI(with viewsControllers: [UIViewController]) -> MyTabBarController {
        let tabBarController = MyTabBarController()
        tabBarController.viewControllers = viewsControllers
        return tabBarController
    }
    
    
    private func createTabBarItem(by viewController: UIViewController, tag: Int){
        viewController.tabBarItem = UITabBarItem(title: "Movies", image: Assets.TabBarItems.movies, tag: tag)
    }

}
