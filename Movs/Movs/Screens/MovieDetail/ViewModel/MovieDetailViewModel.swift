//
//  MovieDetailViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 14/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
  
  var dataSource: MovieDetailDatasource!
  
  // MARK: - Life cycle
  
  init(with datasource: MovieDetailDatasource) {
    self.dataSource = datasource
  }
  
  // MARK: - Public methods
  
  func handlerFavorite(_ movie: Movies, isFaved: Bool, callback: @escaping ((Bool) -> Void)) {
    if !isFaved {
      self.favedMovie(with: movie, callback: callback)
    } else {
      self.unfavedMovie(with: movie.id, callback: callback)
    }
  }
  
  // MARK: - Private methods
  
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
