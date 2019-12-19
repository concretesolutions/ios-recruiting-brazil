//
//  ViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addChild(MoviesListViewController(viewModel: DefaultMoviesListViewModel(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>(), imagesProvider: URLSessionFileProvider(), moviesRouter: { return TMDBMoviesRoute.popular($0) }, imageRouter: { return TMDBMoviesRoute.image($0)})), inView: view)
        
    }
}

