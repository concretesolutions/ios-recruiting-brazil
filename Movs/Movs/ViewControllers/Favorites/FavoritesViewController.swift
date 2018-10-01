//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Dielson Sales on 29/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    enum Constants {
        static let nibName = "FavoritesViewController"
        static let title = "Favorites"
    }

    init() {
        super.init(nibName: Constants.nibName, bundle: nil)
        self.title = Constants.title
        tabBarItem.title = Constants.title
        tabBarItem.image = UIImage(named: "tabItemFavorites")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
