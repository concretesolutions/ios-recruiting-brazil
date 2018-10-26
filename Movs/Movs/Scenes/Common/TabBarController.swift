//
//  TabBarController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        tabBar.barTintColor = UIColor.Movs.yellow
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
    }
    
}
