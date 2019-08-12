//
//  FavoriteMoviesTableViewController.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 11/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesTableViewController: UITableViewController, FavoriteMovieUpdateListener {
    private let favoriteMovieSelectionSegue = "FavoriteMovieSelectionSegue"
    
    var favoriteMoviesData: Array<MovieObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMoviesData(shouldReloadData: false)
        FavoriteMovieCRUD.registerAsListener(self)
    }
    
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
    
    func getMoviesData(shouldReloadData: Bool) {
        self.favoriteMoviesData = FavoriteMovieCRUD.fetchAll().compactMap { favoriteMovie -> MovieObject? in
            if let title = favoriteMovie.attrTitle,
                let release = favoriteMovie.attrRelease,
                let overview = favoriteMovie.attrOverview
            {
                let movieObject = MovieObject(id: Int(favoriteMovie.attrId), title: title, posterPath: favoriteMovie.attrPosterPath, release: release, overview: overview)
                movieObject.poster = favoriteMovie.attrPoster
                return movieObject
            } else {
                return nil
            }
        }
        if shouldReloadData {
            self.tableView.reloadData()
        }
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
        return self.favoriteMoviesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteMovieCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMoviesTableViewCell", for: indexPath) as? FavoriteMoviesTableViewCell else {
            return UITableViewCell()
        }
        favoriteMovieCell.movie = favoriteMoviesData[indexPath.item]
        return favoriteMovieCell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
