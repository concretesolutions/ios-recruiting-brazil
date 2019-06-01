//
//  MovieDetailPresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct MovieDetailViewData {
    
}

//MARK: - VIEW DELEGATE -
protocol MovieDetailViewDelegate: NSObjectProtocol {
    
}

//MARK: - PRESENTER CLASS -
class MovieDetailPresenter {
    
    private weak var viewDelegate: MovieDetailViewDelegate?
    private lazy var viewData = MovieDetailViewData()
    
    init(viewDelegate: MovieDetailViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

//SERVICE
extension MovieDetailPresenter {
    
}

//AUX METHODS
extension MovieDetailPresenter {
    
}

//DATABASE
extension MovieDetailPresenter {
    
}
