//
//  MoviesCollectionViewUpdateDelegate.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import Foundation

protocol MoviesCollectionViewUpdateDelegate: class {
  func loadMoreMovies()
  func canShowFooter() -> Bool
}
