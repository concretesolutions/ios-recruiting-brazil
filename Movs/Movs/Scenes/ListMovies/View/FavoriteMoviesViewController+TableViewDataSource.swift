//
//  FavoriteMoviesViewController+TableViewDataSource.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

extension FavoriteMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteMovieCellReuseIdentifier) as! FavoriteMoviesTableViewCell
        if !movies.isEmpty && !isFilteringMovies {
            cell.configureCellWith(data: movies[indexPath.row])
        } else if !filteredMovies.isEmpty && isFilteringMovies {
            cell.configureCellWith(data: filteredMovies[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilteringMovies {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && !isFilteringMovies {
            let currentMovieId = movies[indexPath.row].id
            let request = FavoriteMoviesModel.Request.Remove(movieId: currentMovieId)
            interactor.removeMovie(request: request)
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
