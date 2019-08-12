//
//  FavoriteMoviesTableViewController.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 11/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesTableViewController: UITableViewController {
    private let favoriteMovieSelectionSegue = "FavoriteMovieSelectionSegue"
    
    var favoriteMoviesData: Array<MovieObject> = []
    
    var searchApplied = false
    var filteredMovieData: Array<MovieObject> = []
    func visibleMovies() -> Array<MovieObject> {
        return self.searchApplied ? self.filteredMovieData : self.favoriteMoviesData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        
        self.getMoviesData(shouldReloadData: false)
        FavoriteMovieCRUD.registerAsListener(self)
    }
    
    func getMoviesData(shouldReloadData: Bool) {
        self.favoriteMoviesData = FavoriteMovieCRUD.fetchAll().compactMap { favoriteMovie -> MovieObject? in
            return MovieObject(from: favoriteMovie)
        }
        if shouldReloadData {
            self.tableView.reloadData()
        }
    }
}

extension FavoriteMoviesTableViewController: FavoriteMovieUpdateListener {
    func onFavoriteMoviesInsert(_ movieObject: MovieObject) {
        self.favoriteMoviesData.append(movieObject)
        self.tableView.reloadData()
    }
    
    func onFavoriteMoviesDelete(_ movieObject: MovieObject) {
        if let unfavoritedMovieIndex = movieObject.findIndex(in: self.favoriteMoviesData) {
            self.favoriteMoviesData.remove(at: unfavoritedMovieIndex)
            self.tableView.reloadData()
        }
    }
}

extension FavoriteMoviesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text, !searchTerm.isEmpty {
            self.searchApplied = true
            self.filteredMovieData = self.favoriteMoviesData.filter { movieObject -> Bool in
                return movieObject.title.lowercased().contains(searchTerm.lowercased())
            }
        }
        else {
            self.searchApplied = false
            self.filteredMovieData = []
        }
        self.tableView.reloadData()
    }
}

//Delegate
extension FavoriteMoviesTableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let movieCell = self.tableView(tableView, cellForRowAt: indexPath) as? FavoriteMoviesTableViewCell {
                movieCell.movie?.removeFromFavorites()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == favoriteMovieSelectionSegue {
            if let movieDetailVC = segue.destination as? MovieDetailViewController, let movieObject = sender as? MovieObject {
                movieDetailVC.movieObject = movieObject
            }
        }
    }    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieCell = self.tableView(tableView, cellForRowAt: indexPath) as? FavoriteMoviesTableViewCell {
            performSegue(withIdentifier: favoriteMovieSelectionSegue, sender: movieCell.movie)
        }
    }
}

//DataSource
extension FavoriteMoviesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visibleMovies().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteMovieCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMoviesTableViewCell", for: indexPath) as? FavoriteMoviesTableViewCell else {
            return UITableViewCell()
        }
        favoriteMovieCell.movie = visibleMovies()[indexPath.item]
        return favoriteMovieCell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
