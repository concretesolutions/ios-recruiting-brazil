//
//  NavigationController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .primary
        
    }
    
}
