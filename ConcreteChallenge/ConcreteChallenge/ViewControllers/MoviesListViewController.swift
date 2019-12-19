//
//  MoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class MoviesListViewController: UIViewController {
    let moviesListView = MoviesListView(viewModel: DefaultMoviesListViewModel(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>(), imagesProvider: URLSessionFileProvider(), moviesRouter: { return TMDBMoviesRoute.popular($0) }, imageRouter: { return TMDBMoviesRoute.image($0)}))
    
    override func viewDidLoad() {
        
        view.addSubViews(moviesListView)
        moviesListView.layout.fillSuperView()
    }
}
 
