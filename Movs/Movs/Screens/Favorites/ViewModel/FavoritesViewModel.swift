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
}

struct FavoritesViewModel {
  
  fileprivate let delegate: FavoritesViewModelDelegate!
  fileprivate let dataSource: FavoritesDatasource!
  
  // MARK: - Life cycle
  
  init(with delegate: FavoritesViewModelDelegate, datasource: FavoritesDatasource) {
    self.delegate = delegate
    self.dataSource = datasource
  }
  
  // MARK: - Public methods
  
  func fetchFavorites() {
    self.success([])
//    MovieServices.shared.fetchMovies { result in
//      switch result {
//      case .success(let moviesList): self.success(moviesList)
//      case .error(let error): self.error(error)
//      }
//    }
  }
  
  // MARK: - Private methods
  
  fileprivate func success(_ movies: [Movies]) {
    dataSource.movies = movies

    guard let delegate = self.delegate else { return }
    delegate.loadFavoritesSuccess()
  }
  
  fileprivate func error(_ error: String) {
    guard let delegate = self.delegate else { return }
    delegate.loadFavoritesError(error)
  }
  
}
