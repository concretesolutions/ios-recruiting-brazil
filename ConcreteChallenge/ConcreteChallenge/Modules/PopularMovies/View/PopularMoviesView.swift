//
//  PopularMoviesView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController, PopularMoviesView {
    
    // MARK: - Outlets
    
    // MARK: - Properties
    var presenter: PopularMoviesPresentation!
    
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    // MARK: - Functions
}

