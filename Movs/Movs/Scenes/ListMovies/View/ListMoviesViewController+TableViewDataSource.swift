//
//  ListMoviesViewController+TableViewDataSource.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

// MARK: - Data Source
extension ListMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarActive {
            return moviesFiltered.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellReuseIdentifier) as! PopularMovieTableViewCell
        var isFavorite: Bool
        
        if isSearchBarActive {
            let currentMovie = moviesFiltered[indexPath.row]
            isFavorite = getFavoriteMovie(currentMovie)
            cell.configureCellWith(data: currentMovie, position: 0, isFavorite: isFavorite)
        } else {
            if !movies.isEmpty {
                let currentMovie = movies[indexPath.row]
                isFavorite = getFavoriteMovie(currentMovie)
                cell.configureCellWith(data: currentMovie, position: indexPath.row + 1, isFavorite: isFavorite)
            } else { cell.loadingCell() }
        }
        return cell
    }
    
    func getPosition(movie: ListMovies.ViewModel.PopularMoviesFormatted) -> Int{
        for element in moviesRanking {
            for (key, value) in element {
                if key == movie.id {
                    return value
                }
            }
        }
        return 0
    }
    
    private func getFavoriteMovie(_ currentMovie: ListMovies.ViewModel.PopularMoviesFormatted) -> Bool {
        return favoriteMovies.contains(where: { (movie) -> Bool in
            return movie.id == currentMovie.id
        })
    }
    
}
