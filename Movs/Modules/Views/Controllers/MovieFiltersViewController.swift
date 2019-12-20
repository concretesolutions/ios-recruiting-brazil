//
//  MovieFiltersViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 19/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieFiltersViewController: UIViewController {
    
    // MARK: - Properties
    
    internal var screen = MovieFiltersViewScreen()
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        self.view = self.screen
    }
}
