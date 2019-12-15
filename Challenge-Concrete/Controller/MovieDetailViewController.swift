//
//  MovieDetailViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = movieDetailView
    }
}
