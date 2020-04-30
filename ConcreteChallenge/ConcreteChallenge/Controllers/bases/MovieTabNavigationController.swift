//
//  MovieTabNavigationController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class MovieTabNavigationController: UINavigationController, BaseTabViewController {
    var tabBarTitle = "Movies"
    var tabBarImage = #imageLiteral(resourceName: "movies")
    var tabBarImageSelected = #imageLiteral(resourceName: "moviesFull")

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
