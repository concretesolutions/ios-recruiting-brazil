//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesDataSource: NSObject, UICollectionViewDataSource {
  
  var movies: [Movie]
  var filteredMovies = [Movie]()
  var posterHeight: CGFloat
  var searchController: UISearchController
  var updateCollectionDelegate: UpdateCollectionDelegate
  
  init(posterHeight: CGFloat, searchController: UISearchController, updateCollectionDelegate: UpdateCollectionDelegate) {
    movies = []
    self.posterHeight = posterHeight
    self.searchController = searchController
    self.updateCollectionDelegate = updateCollectionDelegate
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    var movie: Movie
    
    if !isFiltering() {
      movie = movies[indexPath.row]
    } else {
      movie = filteredMovies[indexPath.row]
    }
    
    cell.configure(withMovie: movie)
    cell.posterHeightLayoutConstraint.constant = posterHeight
    collectionView.layoutIfNeeded()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredMovies.count
    }
    
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerCell", for: indexPath)
    cell.isHidden = true
    return cell
  }
  
}

extension MoviesDataSource: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContent(forSearchedText: searchController.searchBar.text!)
  }
  
  func filterContent(forSearchedText searchedText: String) {
    filteredMovies = movies.filter { (movie) -> Bool in
      return movie.title.lowercased().contains(searchedText.lowercased())
    }
    
    if filteredMovies.isEmpty && !searchedText.isEmpty {
      updateCollectionDelegate.handleResult(hasResults: false, forSearchedString: searchedText)
    } else {
      updateCollectionDelegate.handleResult(hasResults: true, forSearchedString: searchedText)
    }
    
    updateCollectionDelegate.updateCollection()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }
  
}

extension MoviesDataSource: MovieFavoriteStateChangedDelegate {
  func movie(_ movie: Movie, changedToFavorite: Bool) {
    var changedMovie = movie
    changedMovie.isFavorite = changedToFavorite
    
    let indexOnMovies = movies.firstIndex { $0.identificator == changedMovie.identificator }
    let indexOnFilteredMovies = filteredMovies.firstIndex { $0.identificator == changedMovie.identificator }
    
    if let index = indexOnMovies {
      movies[index] = changedMovie
    }
    
    if let index = indexOnFilteredMovies {
      filteredMovies[index] = changedMovie
    }
    
    updateCollectionDelegate.updateCollection()
  }
}

protocol UpdateCollectionDelegate: class {
  func updateCollection()
  func handleResult(hasResults: Bool, forSearchedString string: String)
}
