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
    var favoriteMoviesData: Array<MovieObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateMoviesData(reloadingTableView: false)
        FavoriteMovieFetcher.registerAsListener(self)
    }
    
    func onFavoriteMoviesUpdate() {
        self.updateMoviesData(reloadingTableView: true)
    }
    
    func updateMoviesData(reloadingTableView: Bool) {
        favoriteMoviesData = FavoriteMovieFetcher.fetchAll().compactMap { favoriteMovie -> MovieObject? in
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
        
        if reloadingTableView {
            self.tableView.reloadData()
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
