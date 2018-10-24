//
//  MovsTabBarController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 24/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovsTabBarController: UITabBarController {
    
    let moviesNavigationController:MovsNavigationController = {
        let nav = MovsNavigationController()
        nav.tabBarItem = UITabBarItem(title: nil, image: Assets.listIcon.image, selectedImage: nil)
        return nav
    }()
    let favoritesNavigationController:MovsNavigationController = {
        let nav = MovsNavigationController()
        nav.tabBarItem = UITabBarItem(title: nil, image: Assets.favoriteEmptyIcon.image, selectedImage: nil)
        return nav
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.viewControllers = [moviesNavigationController,favoritesNavigationController]
        self.tabBar.barTintColor = Colors.mainYellow.color
        self.tabBar.tintColor = Colors.darkBlue.color
        self.tabBar.unselectedItemTintColor = Colors.orange.color
    }
}
