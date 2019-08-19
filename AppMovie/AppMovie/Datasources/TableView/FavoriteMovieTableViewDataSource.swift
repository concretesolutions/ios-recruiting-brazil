//
//  MovieDetailTableViewDataSource.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 16/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

final class FavoriteMovieTableViewDataSource: NSObject, UITableViewDataSource {
    
    var movies:[MovieEntity]
    
    init(movies: [MovieEntity], tableView: UITableView) {
        self.movies = movies
        super.init()
        setupTableView(tableView)
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.register(cellType: CellFavoriteMovie.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: CellFavoriteMovie.self)
        let movie = movies[indexPath.row]
        cell.configureCell(movie: movie)
        return cell
    }
    
    
}
