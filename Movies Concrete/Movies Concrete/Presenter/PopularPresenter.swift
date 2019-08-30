//
//  PopularMoviesPresenter.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 30/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import UIKit

protocol PopularProtocol: AnyObject {
  func startLoading(message: String)
  func stopLoading()
  func showError(with message: String)
}

class PopularPresenter {
  
  let request = MoviesServices()
  weak private var popularMoviesView: PopularProtocol?
  
  func attachView(_ view: PopularProtocol) {
    self.popularMoviesView = view
  }
  
  //  MARK: Functions
  
  func setupPopularMovies(data: PopularMoviesViewController, collectionView: UICollectionView, page: Int) {
    self.popularMoviesView?.startLoading(message: "Loading...")
    if Reachability.isConnectedToNetwork() {
      //    Delay just for show loading
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.request.getPopularMovies(data: data, collectionView: collectionView, page: page)
        self.request.getGenreMovies()
        self.popularMoviesView?.stopLoading()
      }
    } else {
      self.popularMoviesView?.showError(with: "Sorry, no internet connection")
      self.popularMoviesView?.stopLoading()
    }
  }
}
