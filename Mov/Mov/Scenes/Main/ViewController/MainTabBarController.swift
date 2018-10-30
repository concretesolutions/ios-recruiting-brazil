//
//  MainTabBarController.swift
//  Mov
//
//  Created by Miguel Nery on 30/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.addViewControllers()
        self.layoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewControllers() {
        let movieGridVC = MovieGridBuilder.build()
        let movieGridNavigationController = UINavigationController(rootViewController: movieGridVC)
        
        self.viewControllers = [movieGridNavigationController]
    }
    
    func layoutSetup() {
        tabBar.barTintColor = Colors.lightYellow
        tabBar.tintColor = Colors.darkBlue
        tabBar.isTranslucent = false
    }
}
