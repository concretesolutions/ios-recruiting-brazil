//
//  PopularMoviesViewModel.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation


class PopularMoviesViewModel {
    
    var delegate: PopularMoviesDelegate?
    
    private var movies: [Movie] = []
    
    func fetchMovies() {
        DataProvider.shared.remoteDataProvider.getPopularMovies(page: 1) { (movies, error) in
            if let _ = error {
                // show error message
            } else if let movies = movies {
                let cellsViewModels = movies.map({ (movie) -> MovieCollectionViewCellViewModel in
                    return MovieCollectionViewCellViewModel(movie: movie)
                })
                self.delegate?.updateCellsViewModels(cellsViewModels)
            }
        }
    }
}
