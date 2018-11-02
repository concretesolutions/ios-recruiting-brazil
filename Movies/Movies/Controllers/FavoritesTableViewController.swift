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
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = false
    
    tableView.register(cellType: FavoriteTableViewCell.self)
    tableView.tableFooterView = UIView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if let movies = LocalStorage.shared.favoriteMovies {
      favoriteMovies = movies.reversed() 
      tableView.reloadData()
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.configure(withMovie: favoriteMovies[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteMovies.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 169
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "favoriteToDetailViewSegue", sender: favoriteMovies[indexPath.row])
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
      favoriteMovies.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
}
