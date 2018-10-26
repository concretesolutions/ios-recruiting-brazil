//
//  NavigationController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        navigationBar.barTintColor = UIColor.Movs.yellow
        navigationBar.tintColor = .black
    }
    
}
