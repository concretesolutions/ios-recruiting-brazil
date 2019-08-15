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
    MovieServices.shared.fetchMovies { result in
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
  
  // MARK: - Private methods
  
  fileprivate func success(_ moviesList: MoviesList) {
    dataSource.movies = moviesList.movies
    dataSource.currentPage = moviesList.actualPage

    guard let delegate = self.delegate else { return }
    delegate.loadMoviesSuccess()
  }
  
  fileprivate func error(_ error: String) {
    guard let delegate = self.delegate else { return }
    delegate.loadMoviesError(error)
  }
  
}
