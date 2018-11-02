//
//  FavoritesRouter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FavoritesRoutingLogic {
    func showFilters()
}

class FavoritesRouter: FavoritesRoutingLogic {
    weak var viewController: FavoritesViewController!
    
    func showFilters() {
        print("Showing filters")
//        let filterViewControlelr = UIViewController()
//        viewController.show(filterViewControlelr, sender: self)
    }
}
