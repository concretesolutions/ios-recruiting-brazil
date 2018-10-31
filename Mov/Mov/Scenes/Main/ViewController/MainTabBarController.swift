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
        self.layoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutSetup() {
        tabBar.barTintColor = Colors.lightYellow
        tabBar.tintColor = Colors.darkBlue
        tabBar.isTranslucent = false
    }
}
