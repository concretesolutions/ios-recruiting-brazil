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
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}

extension TabBarController: CodeView {
    
    func buildViewHierarchy() {}
    func setupConstraints() {}
    
    func setupAdditionalConfiguration() {
        tabBar.barTintColor = UIColor.Movs.yellow
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
    }
    
}
