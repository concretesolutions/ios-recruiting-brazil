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
    private lazy var client = MoviesListClient()
    
    init(with view: MoviesListViewProtocol) {
        viewProtocol = view
    }
}

extension MoviesListPresenter: MoviesListPresenterProtocol {
    var moviesLists: MoviesPages? {
        return client.moviesList
    }
    
    func getMovies() {
        showLoading()
        client.getMoviesList { [weak self] result in
            switch result {
            case let .success(page):
                self?.showSuccess()
                self?.viewProtocol?.addSection(in: page - 1)
            case let .fail(error):
                break
            }
        }
    }
    
    private func showLoading() {
        if  let list = moviesLists,
            list.isEmpty {
            viewProtocol?.hideCollectionView()
            viewProtocol?.showLoading()
        }
    }
    
    private func showSuccess() {
        viewProtocol?.hideLoading()
        viewProtocol?.showCollectionView()
    }
}
