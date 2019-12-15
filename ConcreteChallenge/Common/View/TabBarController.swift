//
//  TabBarController.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.tabBar.tintColor = Colors.tmdbGreen
        self.tabBar.barTintColor = Colors.almostBlack
        self.tabBar.isTranslucent = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
