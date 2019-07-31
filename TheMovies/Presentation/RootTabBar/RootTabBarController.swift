//
//  RootTabBarController.swift
//  ViperitTest
//
//  Created by Matheus Bispo on 7/25/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit

final class RootTabBarController: UITabBarController {
    
    //MARK:- Constructors -
    init(items: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = items
        
        setupTabBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Methods -
    /**
     * Configura a tabBar do aplicativo
     */
    fileprivate func setupTabBar() {
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.borderWidth = 0.50
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.clipsToBounds = true
    }
    
}
