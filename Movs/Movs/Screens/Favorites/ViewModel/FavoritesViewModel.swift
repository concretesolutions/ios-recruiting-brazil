//
//  FavoritesViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 11/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

protocol FavoritesViewModelDelegate {
  func loadFavoritesSuccess()
  func loadFavoritesError(_ error: String)
  func searchWithResult()
  func searchEmpty()
  func filterWithResult()
  func filterEmpty()
  func clearSearch()
  func clearFilter()
}

struct FavoritesViewModel {
  
  fileprivate let delegate: FavoritesViewModelDelegate!
  fileprivate let dataSource: FavoritesDatasource!
  
  var hasFavorites: Bool {
    return dataSource.movies.count > 0
  }
  
  // MARK: - Life cycle
  
  init(with delegate: FavoritesViewModelDelegate, datasource: FavoritesDatasource) {
    self.delegate = delegate
    self.dataSource = datasource
  }
  
  // MARK: - Public methods
  
  func fetchFavorites() {
    let favedMovies = MovsSingleton.shared.allMovies.filter { $0.faved }
    self.success(favedMovies)
  }
  
  func makeMovieDetail(at index: IndexPath) -> MovieDetailViewModel {
    let datasource = MovieDetailDatasource()
    let viewModel = MovieDetailViewModel(with: datasource)
    let movie = self.dataSource.movies[index.row]
    
    datasource.movie = movie
    
    return viewModel
  }
  
  func removeFavorite(at index: IndexPath) {
    let movie = dataSource.movies[index.row]

    DataManager.shared.unfaved(with: movie.id) { _ in
      self.dataSource.movies.remove(at: index.row)
    }
  }
  
  func search(with term: String) {
    dataSource.inSearch = true
    
    dataSource.movies = dataSource.movies.filter({ movie -> Bool in
      return movie.title.contains(term) || movie.overview.contains(term)
    })
    
    dataSource.movies.count > 0 ? delegate.searchWithResult() : delegate.searchEmpty()
  }
  
  func clearSearch() {
    dataSource.inSearch = false
    delegate.clearSearch()
  }
  
  func applyFilter(_ filters: Filters) {
    dataSource.filterEnable = true

    // Filter by year
    if !filters.year.isEmpty {
      dataSource.movies = dataSource.movies.filter({ movie -> Bool in
        return movie.releaseAt.toDate().format(with: "yyyy") == filters.year
      })
    }
    
    // Filter by genres
    if filters.genres.count > 0 {
      dataSource.movies = dataSource.movies.filter({ movie -> Bool in
        return movie.genres.containsElements(of: filters.genres)
      })
    }
    
    dataSource.movies.count > 0 ? delegate.filterWithResult() : delegate.filterEmpty()
  }
  
  func clearFilter() {
    dataSource.filterEnable = false
    delegate.clearFilter()
  }
  
  // MARK: - Private methods
  
  fileprivate func success(_ movies: [Movies]) {
    dataSource.movies = movies

    guard let delegate = self.delegate else { return }
    delegate.loadFavoritesSuccess()
  }

}
