//
//  HomeTabBarViewController.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    var presenter:HomeTabBarPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidLoad()
        
        self.tabBar.barStyle = .default
        self.tabBar.barTintColor = UIColor.black
    }
}
