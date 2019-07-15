//
//  FavoritesMoviesViewModel.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation


class FavoritesMoviesViewModel {
    
    var delegate: FavoritesMoviesDelegate?
    
    var cellsViewModels: [FavoriteTableViewCellViewModel] = [] {
        didSet {
            self.filteredCellsViewModels = self.cellsViewModels
        }
    }
    
    
    var filteredCellsViewModels:  [FavoriteTableViewCellViewModel] = [] {
        didSet {
            self.delegate?.updateCellsViewModels(self.filteredCellsViewModels)
        }
    }
    
    func getDetailsViewModel(cellViewModel: FavoriteTableViewCellViewModel) -> MovieDetailsViewModel? {
        let selectedMovie = self.filteredCellsViewModels.filter { (model) -> Bool in
            return model.movieId == cellViewModel.movieId
        }.first?.movie
        guard let movie = selectedMovie else {return nil}
        return MovieDetailsViewModel(movie: movie)
    }
    
    func fetchMovies() {
        DataProvider.shared.remoteDataProvider.getPopularMovies(page: 1) { (movies, error) in
            if let _ = error {
                // show error message
            } else if let movies = movies {
                let cellsViewModels = movies.filter({ (movie) -> Bool in
                    return DataProvider.shared.favoritesProvider.isFavorite(movie.id!)
                }).map({ (movie) -> FavoriteTableViewCellViewModel in
                    return FavoriteTableViewCellViewModel(movie: movie)
                })
                self.cellsViewModels = cellsViewModels
            }
        }
    }
    
    func removeFavorite(with cellViewModel: FavoriteTableViewCellViewModel) {
        
        let _ = DataProvider.shared.favoritesProvider.delete(withId: cellViewModel.movieId)
        
    }
    
    func filterBySearch(_ searchText: String) {
        self.filteredCellsViewModels = self.cellsViewModels.filter({ (model) -> Bool in
            return !searchText.isEmpty ? model.isOnSearch(searchText) : true
        })
    }
}
