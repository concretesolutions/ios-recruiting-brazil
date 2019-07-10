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

    var cellsViewModels: [MovieCollectionViewCellViewModel] = [] {
        didSet {
            self.filteredCellsViewModels = self.cellsViewModels
        }
    }
    
    var filteredCellsViewModels:  [MovieCollectionViewCellViewModel] = [] {
        didSet {
            self.delegate?.updateCellsViewModels(self.filteredCellsViewModels)
        }
    }
    
    func fetchMovies() {
        DataProvider.shared.remoteDataProvider.getPopularMovies(page: 1) { (movies, error) in
            if let _ = error {
                // show error message
            } else if let movies = movies {
                let cellsViewModels = movies.map({ (movie) -> MovieCollectionViewCellViewModel in
                    return MovieCollectionViewCellViewModel(movie: movie)
                })
                self.cellsViewModels = cellsViewModels
            }
        }
    }
    
    func filterBySearch(_ searchText: String) {
        self.filteredCellsViewModels = self.cellsViewModels.filter({ (model) -> Bool in
            return !searchText.isEmpty ? model.isOnSearch(searchText) : true
        })
    }
    
}
