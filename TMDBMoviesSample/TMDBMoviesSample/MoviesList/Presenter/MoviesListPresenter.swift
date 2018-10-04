//
//  MoviesListPresenter.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MoviesListPresenter {
    private weak var viewProtocol: MoviesListViewProtocol?
    
    init(with view: MoviesListViewProtocol) {
        viewProtocol = view
    }
}

extension MoviesListPresenter: MoviesListPresenterProtocol {
    
}
