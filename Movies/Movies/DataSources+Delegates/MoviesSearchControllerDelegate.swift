//
//  MoviesSearchControllerDelegate.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 03/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import Foundation

protocol MoviesSearchControllerDelegate: class {
  func searchContent(forSearchedText searchedText: String)
  func searchBarIsEmpty() -> Bool
  func isOnSearch() -> Bool
}
