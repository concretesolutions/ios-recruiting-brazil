//
//  FavoritesPresenter.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 30/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//


import Foundation
import UIKit

protocol FavoritesProtocol: AnyObject {
  func startLoading(message: String)
  func stopLoading()
  func showError(with message: String)
}

class FavoritesPresenter {
  
  let request = MoviesServices()
  weak private var favoriteMoviesView: FavoritesProtocol?
  
  func attachView(_ view: FavoritesProtocol) {
    self.favoriteMoviesView = view
  }
  
  //  MARK: Functions
    
  func setupGenresMovies() {
    if Reachability.isConnectedToNetwork() {
      self.request.getGenreMovies()
    } else {
      self.favoriteMoviesView?.showError(with: "Sorry, no internet connection")
    }
  }
}


