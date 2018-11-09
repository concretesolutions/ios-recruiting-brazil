//
//  MovieDetailController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {

    // MARK: - Properties
    public var movie = Results()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
        
    }
    
    // MARK: - UI Config
    private func uiConfig() {
        navigationItem.title = movie.title
    }
    
    
}
