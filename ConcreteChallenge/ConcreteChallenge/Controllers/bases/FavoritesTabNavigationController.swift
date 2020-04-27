//
//  FavoritesTabNavigationController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class FavoritesTabNavigationController: UINavigationController, BaseTabViewController {
    var tabBarTitle = "Favorites"
    var tabBarImage = #imageLiteral(resourceName: "heart")
    var tabBarImageSelected = #imageLiteral(resourceName: "heartFull")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgColor = UIColor(asset: .brand)
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = bgColor
        self.view.backgroundColor = bgColor

        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
            self.navigationBar.backgroundColor = bgColor
        }
        
    }
}

