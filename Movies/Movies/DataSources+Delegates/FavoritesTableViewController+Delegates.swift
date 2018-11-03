//
//  FavoritesTableViewController+Delegates.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 03/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

/////////////////////////////////////////
//
// MARK: Filter table delegate
//
/////////////////////////////////////////
extension FavoritesTableViewController: FilterTableViewControllerDelegate {
  
  func didChangeFilterValues(_ selectedYear: Int?, selectedGenre: Genre?) {
    self.selectedYear = selectedYear
    self.selectedGenre = selectedGenre
    
    if isOnFilter() {
      filterBarButtonItem.title = "Filter ON"
      applyFilter()
    } else {
      filterBarButtonItem.title = "Apply Filter"
    }
  }
  
  func applyFilter(withReloadData: Bool = true) {
    filteredMovies = favoriteMovies.filter { (movie) -> Bool in
      var validYear = true
      var validGenre = true
      
      if let appliedYear = selectedYear {
        if Calendar.current.component(.year, from: movie.releaseDate) != appliedYear {
          validYear = false
        }
      }
      
      if let appliedGenre = selectedGenre {
        validGenre = false
        movie.genresID.forEach({ (identificator) in
          if appliedGenre.identificator == identificator {
            validGenre = true
          }
        })
      }
      
      return validYear && validGenre
    }
    
    if withReloadData {
      tableView.reloadData()
    }
    
  }
  
  func isOnFilter() -> Bool {
    return selectedGenre != nil || selectedYear != nil
  }
  
}

/////////////////////////////////////////
//
// MARK: UISearchResultsUpdating and MoviesSearchControllerDelegate
//
/////////////////////////////////////////
extension FavoritesTableViewController: UISearchResultsUpdating, MoviesSearchControllerDelegate {
  
  func updateSearchResults(for searchController: UISearchController) {
    searchContent(forSearchedText: searchController.searchBar.text!)
  }
  
  func searchContent(forSearchedText searchedText: String) {
    let movies: [Movie]
    
    if isOnFilter() {
      movies = filteredMovies
    } else {
      movies = favoriteMovies
    }
    
    searchedFavorites = movies.filter { (movie) -> Bool in
      return movie.title.lowercased().contains(searchedText.lowercased())
    }
    
    if searchedFavorites.isEmpty && !searchedText.isEmpty {
      currentSearchState = .noResults(searchedText)
    } else {
      currentSearchState = .searching
    }
    
    tableView.reloadData()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isOnSearch() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }
  
}
