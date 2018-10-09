//
//  MoviesListPresenter.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation
import UIKit

class FavoritesMoviesListPresenter {
    private weak var viewProtocol: FavoritesMoviesListViewProtocol?
    private lazy var client = FavoritesMoviesListClient()
    
    init(with view: FavoritesMoviesListViewProtocol) {
        viewProtocol = view
    }
}

extension FavoritesMoviesListPresenter: FavoritesMoviesListPresenterProtocol {
    var movies: [MovieDetailModel] {
        return client.moviesList
    }
    
    func openMovieDetail(to indexPath: IndexPath) {
        let detailStoryboard = UIStoryboard(name: "MovieDetailView", bundle: nil)
        guard let detailVC = detailStoryboard.instantiateInitialViewController() as? MovieDetailViewController else { return }
        
        let detailModel = movies[indexPath.item]
        detailVC.model = detailModel
        viewProtocol?.show(with: detailVC)
    }
    
    func getMovies() {
        
    }
}
