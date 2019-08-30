//
//  FilterPresenter.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 30/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import UIKit

protocol FilterProtocol: AnyObject {
  func showError(with message: String)
}

class FilterPresenter {
  
  let request = MoviesServices()
  weak private var filterView: FilterProtocol?
  
  func attachView(_ view: FilterProtocol) {
    self.filterView = view
  }
  
  //  MARK: Functions
  
  func getGenresMovies() {
    if Reachability.isConnectedToNetwork() {
      self.request.getGenreMovies()
    } else {
      self.filterView?.showError(with: "Sorry, no internet connection")
    }
  }
}
