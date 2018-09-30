//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Dielson Sales on 29/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    static let nibName = "FavoritesViewController"

    init() {
        super.init(nibName: FavoritesViewController.nibName, bundle: nil)
        tabBarItem.title = "Favorites"
        tabBarItem.image = UIImage(named: "tabItemFavorites")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
