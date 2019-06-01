//
//  MovieListPresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct MovieListViewData {
    
}

//MARK: - VIEW DELEGATE -
protocol MovieListViewDelegate: NSObjectProtocol {
    
}

//MARK: - PRESENTER CLASS -
class MovieListPresenter {
    
    private weak var viewDelegate: MovieListViewDelegate?
    private lazy var viewData = MovieListViewData()
    
    init(viewDelegate: MovieListViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

//SERVICE
extension MovieListPresenter {
    
}

//AUX METHODS
extension MovieListPresenter {
    
}

//DATABASE
extension MovieListPresenter {
    
}
