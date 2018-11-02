//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit
import Reusable

class FavoritesTableViewController: UITableViewController {

  var favoriteMovies: [Movie] = []
  var searchedFavorites: [Movie] = []
  var searchController: UISearchController!
  
  fileprivate func setupSearchController() {
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Movies"
    definesPresentationContext = true
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSearchController()

    tableView.register(cellType: FavoriteTableViewCell.self)
    tableView.tableFooterView = UIView()
  }
  
  fileprivate func updateTableViewFromStorage(withReloadData: Bool = true) {
    if let movies = LocalStorage.shared.favoriteMovies {
      favoriteMovies = movies.reversed()
      if withReloadData {
       tableView.reloadData()
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    updateTableViewFromStorage()
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    let movie: Movie
    
    if isOnSearch() {
      movie = searchedFavorites[indexPath.row]
    } else {
      movie = favoriteMovies[indexPath.row]
    }
    
    cell.configure(withMovie: movie)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isOnSearch() {
      return searchedFavorites.count
    }
    
    return favoriteMovies.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 169
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie: Movie
    if isOnSearch() {
      movie = searchedFavorites[indexPath.row]
    } else {
      movie = favoriteMovies[indexPath.row]
    }
    performSegue(withIdentifier: "favoriteToDetailViewSegue", sender: movie)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "favoriteToDetailViewSegue" {
      if let destinationViewController = segue.destination as? MovieDetailViewController {
        if let aMovie = sender as? Movie {
          destinationViewController.movie = aMovie
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      LocalStorage.shared.removeFavorite(movie: favoriteMovies[indexPath.row])
      
      if isOnSearch() {
        searchedFavorites.remove(at: indexPath.row)
      } else {
        favoriteMovies.remove(at: indexPath.row)
      }
      
      tableView.deleteRows(at: [indexPath], with: .fade)
      updateTableViewFromStorage(withReloadData: false)
    }
  }

}

extension FavoritesTableViewController: UISearchResultsUpdating, MoviesSearchControllerDelegate {
  func updateSearchResults(for searchController: UISearchController) {
      searchContent(forSearchedText: searchController.searchBar.text!)
  }
  
  func searchContent(forSearchedText searchedText: String) {
    searchedFavorites = favoriteMovies.filter { (movie) -> Bool in
      return movie.title.lowercased().contains(searchedText.lowercased())
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

protocol MoviesSearchControllerDelegate: class {
  func searchContent(forSearchedText searchedText: String)
  func searchBarIsEmpty() -> Bool
  func isOnSearch() -> Bool
}
