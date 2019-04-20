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
        viewControllers = [movies.navigationController, bookmarks.navigationController]
    }
}
