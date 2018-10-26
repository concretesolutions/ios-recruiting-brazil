//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupViewController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewController()
    }
    
    private func setupViewController() {
        view.backgroundColor = .white
        title = "Favorites"
        tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "FavoriteEmptyIcon"), tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
