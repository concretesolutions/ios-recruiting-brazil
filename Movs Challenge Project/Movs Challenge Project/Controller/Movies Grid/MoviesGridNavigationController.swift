//
//  MoviesGridNavigationController.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 12/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class MoviesGridNavigationController: UINavigationController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let popularMoviesVC = PopularMoviesViewController()
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
    
    private func initController() {
        tabBarItem = UITabBarItem(title: "Movies", image: .listIcon, selectedImage: nil)
        view.tintColor = .mvYellow
        
        popularMoviesVC.setCustomNavigationBar(title: "Movies", color: .mvText)
        viewControllers = [popularMoviesVC]
    }
}
