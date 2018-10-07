//
//  MoviesListPresenter.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation
import UIKit

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
    
    func openMovieDetail(to indexPath: IndexPath) {
        let detailStoryboard = UIStoryboard(name: "MovieDetailView", bundle: nil)
        guard
            let movie = moviesLists?[indexPath.section][indexPath.item],
            let detailModel = getDetailModel(with: movie),
            let detailVC = detailStoryboard.instantiateInitialViewController() as? MovieDetailViewController
        else { return }
        
        detailVC.model = detailModel
        viewProtocol?.show(with: detailVC)
    }
    
    private func getDetailModel(with movie: MovieModel) -> MovieDetailModel? {
        guard
            let title = movie.title,
            let releaseDate = movie.releaseDate,
            let description = movie.description,
            let genreIds = movie.genreIds,
            let backdropPath = movie.backdropPath
            else { return nil }
        
        let releaseYear = releaseDate.prefix(4)
        let detailModel = MovieDetailModel(title: title, releaseYear: String(releaseYear), genreIds: genreIds, description: description, backdropPath: backdropPath)
        return detailModel
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
