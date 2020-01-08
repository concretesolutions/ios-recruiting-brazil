//
//  TabBarController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 07/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

