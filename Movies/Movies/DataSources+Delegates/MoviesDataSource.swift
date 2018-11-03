//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesDataSource: NSObject, UICollectionViewDataSource {
  
  // MARK: Properties
  
  var movies: [Movie]
  
  var searchedMovies = [Movie]()
  
  var posterHeight: CGFloat
  
  var searchController: UISearchController
  
  var updateCollectionDelegate: UpdateCollectionDelegate
  
  // MARK: Initialization
  
  init(posterHeight: CGFloat, searchController: UISearchController, updateCollectionDelegate: UpdateCollectionDelegate) {
    movies = []
    self.posterHeight = posterHeight
    self.searchController = searchController
    self.updateCollectionDelegate = updateCollectionDelegate
  }
  
  // MARK: - Table view data source
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    var movie: Movie
    
    if !isOnSearch() {
      movie = movies[indexPath.row]
    } else {
      movie = searchedMovies[indexPath.row]
    }
    
    cell.configure(withMovie: movie)
    cell.posterHeightLayoutConstraint.constant = posterHeight
    collectionView.layoutIfNeeded()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isOnSearch() {
      return searchedMovies.count
    }
    
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerCell", for: indexPath)
    cell.isHidden = true
    return cell
  }
  
}

/////////////////////////////////////////
//
// MARK: UISearchResultsUpdating and MoviesSearchControllerDelegate methods
//
/////////////////////////////////////////
extension MoviesDataSource: UISearchResultsUpdating, MoviesSearchControllerDelegate {
  
  func updateSearchResults(for searchController: UISearchController) {
    searchContent(forSearchedText: searchController.searchBar.text!)
  }
  
  func searchContent(forSearchedText searchedText: String) {
    searchedMovies = movies.filter { (movie) -> Bool in
      return movie.title.lowercased().contains(searchedText.lowercased())
    }
    
    if searchedMovies.isEmpty && !searchedText.isEmpty {
      updateCollectionDelegate.handleResult(hasResults: false, forSearchedString: searchedText)
    } else {
      updateCollectionDelegate.handleResult(hasResults: true, forSearchedString: searchedText)
    }
    
    updateCollectionDelegate.updateCollection()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isOnSearch() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }
  
}

/////////////////////////////////////////
//
// MARK: MovieFavoriteStateChangedDelegate methods
//
/////////////////////////////////////////
extension MoviesDataSource: MovieFavoriteStateChangedDelegate {
  func movie(_ movie: Movie, changedToFavorite: Bool) {
    var changedMovie = movie
    changedMovie.isFavorite = changedToFavorite
    
    let indexOnMovies = movies.firstIndex { $0.identificator == changedMovie.identificator }
    let indexOnFilteredMovies = searchedMovies.firstIndex { $0.identificator == changedMovie.identificator }
    
    if let index = indexOnMovies {
      movies[index] = changedMovie
    }
    
    if let index = indexOnFilteredMovies {
      searchedMovies[index] = changedMovie
    }
    
    updateCollectionDelegate.updateCollection()
  }
}

protocol UpdateCollectionDelegate: class {
  func updateCollection()
  func handleResult(hasResults: Bool, forSearchedString string: String)
}
