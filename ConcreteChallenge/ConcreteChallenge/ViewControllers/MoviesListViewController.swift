//
//  MoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    let moviesListView = MoviesListView(viewModel: .init())
    
    override func viewDidLoad() {
        
        view.addSubViews(moviesListView)
        moviesListView.layout.fillSuperView()
    }
}
