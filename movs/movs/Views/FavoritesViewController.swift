//
//  FavoritesViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizable.movies
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .filterIcon, style: .plain, target: self, action: #selector(self.filterAction))
    }
    
    @objc private func filterAction() {
        let view = FilterViewController()
        let nav = NavigationController(rootViewController: view)
        self.present(nav, animated: true, completion: nil)
    }

}
