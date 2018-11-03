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
  var filteredMovies: [Movie] = []
  var selectedYear: Int?
  var selectedGenre: Genre?
  lazy var filterBarButtonItem: UIBarButtonItem = {
    let barButton = UIBarButtonItem(title: "Apply Filter", style: .plain, target: self, action: #selector(showFilterViewController))
    return barButton
  }()
  
  @objc func showFilterViewController() {
    performSegue(withIdentifier: "toFilterSegue", sender: nil)
  }
  
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
    
    navigationItem.rightBarButtonItem = filterBarButtonItem
    tableView.register(cellType: FavoriteTableViewCell.self)
    tableView.tableFooterView = UIView()
  }
  
  fileprivate func updateTableViewFromStorage(withReloadData: Bool = true) {
    if let movies = LocalStorage.shared.favoriteMovies {
      favoriteMovies = movies.reversed()
      if isOnFilter() {
        applyFilter(withReloadData: withReloadData)
      }
      
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
      if isOnFilter() {
        movie = filteredMovies[indexPath.row]
      } else {
        movie = favoriteMovies[indexPath.row]
      }
    }
    
    cell.configure(withMovie: movie)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isOnSearch() {
      return searchedFavorites.count
    } else {
      if isOnFilter() {
        return filteredMovies.count
      } else {
        return favoriteMovies.count
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 169
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie: Movie
    
    if isOnSearch() {
      movie = searchedFavorites[indexPath.row]
    } else {
      if isOnFilter() {
        movie = filteredMovies[indexPath.row]
      } else {
        movie = favoriteMovies[indexPath.row]
      }
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
    } else if segue.identifier == "toFilterSegue" {
      if let destinationViewController = segue.destination as? FilterTableViewController {
        destinationViewController.filterDelegate = self
        favoriteMovies.forEach { movie in
          let movieYearString = "\(Calendar.current.component(.year, from: movie.releaseDate))"
          if !destinationViewController.years.contains(movieYearString) {
            destinationViewController.years.append(movieYearString)
          }
          
          movie.genresID.forEach({ (identificator) in
            if !destinationViewController.genresIds.contains(identificator) {
              destinationViewController.genresIds.append(identificator)
            }
          })
        }
        
        destinationViewController.years = destinationViewController.years.sorted(by: >)
        
        if isOnFilter() {
          if let year = selectedYear {
            destinationViewController.selectedYear = year
          }
          
          if let genre = selectedGenre {
            destinationViewController.selectedGenre = genre
          }
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
//      if isOnFilter() {
//        LocalStorage.shared.removeFavorite(movie: filteredMovies[indexPath.row])
//      } else {
//        LocalStorage.shared.removeFavorite(movie: favoriteMovies[indexPath.row])
//      }
      
      if isOnSearch() {
        LocalStorage.shared.removeFavorite(movie: searchedFavorites[indexPath.row])
        searchedFavorites.remove(at: indexPath.row)
      } else {
        if isOnFilter() {
          LocalStorage.shared.removeFavorite(movie: filteredMovies[indexPath.row])
          filteredMovies.remove(at: indexPath.row)
        } else {
          LocalStorage.shared.removeFavorite(movie: favoriteMovies[indexPath.row])
          favoriteMovies.remove(at: indexPath.row)
        }
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
    let movies: [Movie]
    
    if isOnFilter() {
      movies = filteredMovies
    } else {
      movies = favoriteMovies
    }
    
    searchedFavorites = movies.filter { (movie) -> Bool in
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

protocol MoviesSearchControllerDelegate: class {
  func searchContent(forSearchedText searchedText: String)
  func searchBarIsEmpty() -> Bool
  func isOnSearch() -> Bool
}
