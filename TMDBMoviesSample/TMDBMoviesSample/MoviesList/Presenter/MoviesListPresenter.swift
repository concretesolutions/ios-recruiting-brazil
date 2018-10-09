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
    
    var filteredList: [MovieModel] = []
    
    init(with view: MoviesListViewProtocol) {
        viewProtocol = view
    }
}

extension MoviesListPresenter: MoviesListPresenterProtocol {
    var moviesLists: MoviesPages? {
        return client.moviesList
    }
    
    func openMovieDetail(to indexPath: IndexPath, comeFromSearch: Bool) {
        let detailStoryboard = UIStoryboard(name: "MovieDetailView", bundle: nil)
        guard
            let movie = getMovieModel(in: indexPath, comeFromSearch),
            let detailModel = getDetailModel(with: movie),
            let detailVC = detailStoryboard.instantiateInitialViewController() as? MovieDetailViewController
        else { return }
        
        detailVC.model = detailModel
        viewProtocol?.show(with: detailVC)
    }
    
    private func getMovieModel(in indexPath: IndexPath, _ comeFromSearch: Bool) -> MovieModel? {
        if comeFromSearch {
            return filteredList[indexPath.row]
        } else {
            return moviesLists?[indexPath.section][indexPath.item]
        }
    }
    
    private func getDetailModel(with movie: MovieModel) -> MovieDetailModel? {
        guard
            let title = movie.title,
            let releaseDate = movie.releaseDate,
            let description = movie.description,
            let genreIds = movie.genreIds,
            let id = movie.id
        else { return nil }
        
        let releaseYear = releaseDate.prefix(4)
        let detailModel = MovieDetailModel(title: title, releaseYear: String(releaseYear), genreIds: genreIds, description: description, id: id)
        detailModel.posterData = movie.posterImageData
        return detailModel
    }
    
    func getMovies() {
        showLoading()
        client.getMoviesList { [weak self] result in
            switch result {
            case let .success(page):
                self?.showSuccess()
                self?.viewProtocol?.addSection(in: page - 1)
                self?.viewProtocol?.setupSearchBar()
            case .fail(_):
                self?.showError()
            }
        }
    }
    
    func getMoviePoster(to model: MovieModel, completion: @escaping (ResponseResultType<Data>, String) -> Void) {
        guard let posterPath = model.posterPath else { return }
        client.getMoviePoster(posterPath: posterPath, completion: completion)
    }
    
    func filterList(with textFilter: String) {
        var movieList: [MovieModel] = []
        moviesLists?.forEach {
            movieList.append(contentsOf: $0.filter { $0.title?.contains(textFilter) ?? false })
        }
        filteredList = movieList
    }
    
    func changeSearchCollectionState(shouldShowEmptySearch: Bool) {
        if shouldShowEmptySearch {
            viewProtocol?.showEmptySearchLabel()
            viewProtocol?.hideCollectionView()
        } else {
            viewProtocol?.hideEmptySearchLabel()
            viewProtocol?.showCollectionView()
        }
    }
    
    func cancelTasks() {
        client.cancelTask()
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
