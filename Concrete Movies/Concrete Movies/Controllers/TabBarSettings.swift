//
//  TabBarDelegate.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import UIKit

class TabBarSettings: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBar.items?[0].image = UIImage(named: "list_icon")
        self.tabBar.items?[1].image = UIImage(named: "favorite_full_icon")
    }
}
