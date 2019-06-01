//
//  MovieListViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: OUTLETS
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: MovieListPresenter!
    private lazy var viewData:MovieListViewData = MovieListViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension MovieListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieListPresenter(viewDelegate: self)
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieListViewController: MovieListViewDelegate {

}

//MARK: - AUX METHODS -
extension MovieListViewController {

}
