//
//  MovieDetailViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: OUTLETS
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: MovieDetailPresenter!
    private lazy var viewData:MovieDetailViewData = MovieDetailViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieDetailPresenter(viewDelegate: self)
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieDetailViewController: MovieDetailViewDelegate {

}

//MARK: - AUX METHODS -
extension MovieDetailViewController {

}
