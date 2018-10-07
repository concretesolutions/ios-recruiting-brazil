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
            case .fail(_):
                self?.showError()
            }
        }
    }
    
    func getMoviePoster(to model: MovieModel, completion: @escaping (ResponseResultType<Data>, String) -> Void) {
        guard let posterPath = model.posterPath else { return }
        client.getMoviePoster(posterPath: posterPath, completion: completion)
    }
    
    private func showError() {
        if  let list = moviesLists,
            list.isEmpty {
            if let errorIsShowing = viewProtocol?.errorIsShowing,
                errorIsShowing {
                viewProtocol?.hideErrorLoading()
            } else {
                viewProtocol?.hideLoading()
                viewProtocol?.showErrorView()
            }
        }
    }
    
    private func showLoading() {
        if let errorIsShowing = viewProtocol?.errorIsShowing,
            errorIsShowing {
            viewProtocol?.showErrorLoading()
        } else if let list = moviesLists,
            list.isEmpty {
            viewProtocol?.hideCollectionView()
            viewProtocol?.showLoading()
        }
    }
    
    private func showSuccess() {
        viewProtocol?.hideLoading()
        viewProtocol?.hideErrorView()
        viewProtocol?.showCollectionView()
    }
}
