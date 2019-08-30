//
//  DetailPresenter.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 30/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import UIKit

protocol DetailProtocol: AnyObject {
  func showError(with message: String)
}

class DetailPresenter {
  
  let request = MoviesServices()
  weak private var movieDetailView: DetailProtocol?
  
  func attachView(_ view: DetailProtocol) {
    self.movieDetailView = view
  }
  
  //  MARK: Functions
  
  func getGenresMovies() {
    if Reachability.isConnectedToNetwork() {
      self.request.getGenreMovies()
    } else {
      self.movieDetailView?.showError(with: "Sorry, no internet connection")
    }
  }
}


