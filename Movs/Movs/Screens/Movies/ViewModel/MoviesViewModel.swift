//
//  MoviesViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

protocol MoviesViewModelDelegate {
  func loadMoviesSuccess()
  func loadMoviesError(_ error: String)
  func searchWithResult()
  func searchEmpty()
  func clearSearch()
}

struct MoviesViewModel {
  
  fileprivate let delegate: MoviesViewModelDelegate!
  fileprivate let dataSource: MoviesDatasource!
  
  // MARK: - Life cycle
  
  init(with delegate: MoviesViewModelDelegate, datasource: MoviesDatasource) {
    self.delegate = delegate
    self.dataSource = datasource
  }
  
  // MARK: - Public methods
  
  func fetchMovies() {
    MovieServices.shared.fetchMovies(page: dataSource.currentPage) { result in
      switch result {
      case .success(let moviesList): self.success(moviesList)
      case .error(let error): self.error(error)
      }
    }
  }
  
  func makeMovieDetail(at index: IndexPath) -> MovieDetailViewModel {
    let datasource = MovieDetailDatasource()
    let viewModel = MovieDetailViewModel(with: datasource)
    let movie = self.dataSource.movies[index.row]
    
    datasource.movie = movie
    
    return viewModel
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
  
  func handlerFavorite(_ movie: Movies, isFaved: Bool, callback: @escaping ((Bool) -> Void)) {
    if !isFaved {
      self.favedMovie(with: movie, callback: callback)
    } else {
      self.unfavedMovie(with: movie.id, callback: callback)
    }
  }
  
  func nextPage() {
    // Increment page
    dataSource.currentPage += 1

    // Check if all pages loaded
    if dataSource.totalPages == dataSource.currentPage { return }

    self.fetchMovies()
  }
  
  // MARK: - Private methods
  
  fileprivate func success(_ moviesList: MoviesList) {
    dataSource.currentPage = moviesList.actualPage
    dataSource.totalPages = moviesList.totalPages

    // Clear data source array if page equals 1
    if dataSource.currentPage == 1 {
      dataSource.movies.removeAll()
    }

    dataSource.movies.append(contentsOf: moviesList.movies)

    // Update singleton with movies loaded
    MovsSingleton.shared.allMovies.removeAll()
    MovsSingleton.shared.allMovies.append(contentsOf: dataSource.movies)
    
    guard let delegate = self.delegate else { return }
    delegate.loadMoviesSuccess()
  }
  
  fileprivate func error(_ error: String) {
    guard let delegate = self.delegate else { return }
    delegate.loadMoviesError(error)
  }
  
  fileprivate func favedMovie(with movie: Movies, callback: @escaping ((Bool) -> Void)) {
    DataManager.shared.faved(with: movie) { result in
      switch result {
      case .success: callback(true)
      case .error(let error):
        debugPrint(error)
        callback(false)
      }
    }
  }
  
  fileprivate func unfavedMovie(with id: Int, callback: @escaping ((Bool) -> Void)) {
    DataManager.shared.unfaved(with: id, callback: callback)
  }
  
}
