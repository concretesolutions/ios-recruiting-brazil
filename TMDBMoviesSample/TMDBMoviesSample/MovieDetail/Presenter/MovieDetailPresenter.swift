//
//  MovieDetailPresenter.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieDetailPresenter {
    
    
    private weak var viewProtocol: MovieDetailViewProtocol?
    
    init(with view: MovieDetailViewProtocol) {
        viewProtocol = view
    }
}

//MARK: - Protocol methods -
extension MovieDetailPresenter: MoviePresenterProtocol {
    func getGenreList() {
        viewProtocol?.showGenreLoading()
    }
}
