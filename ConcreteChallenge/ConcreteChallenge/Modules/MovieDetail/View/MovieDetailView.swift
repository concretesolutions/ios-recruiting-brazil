//
//  MovieDetailView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailView {
    
    // MARK: - Outlets
    
    // MARK: - Properties
    var presenter: MovieDetailPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    // MARK: - MovieDetailView Functions
    
    // MARK: - Functions
    
}

