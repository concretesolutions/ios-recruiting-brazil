//
//  FavoritesCoordinator.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    init() {
        self.rootViewController = UIViewController()
        self.rootViewController.view.backgroundColor = .red
    }
    
    func start() {
        
    }
}
