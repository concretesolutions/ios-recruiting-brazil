//
//  MoviesCoordinator.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
/**
 Coordinator Responsible for the Movies View
*/
class MoviesCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    init() {
        self.rootViewController = UIViewController()
        self.rootViewController.view.backgroundColor = .blue

    }
    
    func start() {
        
    }
}
