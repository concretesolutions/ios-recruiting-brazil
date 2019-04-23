//
//  TabBarController.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let movies = MainCoordinator(navigationController: UINavigationController())
    let bookmarks = MainCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        movies.start()
        bookmarks.startBookmarks()
        UITabBar.appearance().barTintColor = UIColor(rgb: Const.mainColor)
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        viewControllers = [movies.navigationController, bookmarks.navigationController]
    }
}
