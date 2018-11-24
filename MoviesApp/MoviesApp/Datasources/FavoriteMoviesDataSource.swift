//
//  FavoriteMoviesDataSource.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class FavoriteMoviesDataSource:NSObject{
    
    var movies:[CDMovie] = []
    
    //Filtering
//    var filteredMovies:[CDMovie] = []
//    var isFiltering = false
    
    weak var tableView:UITableView?
    weak var delegate:UITableViewDelegate?
    
    required init(movies:[CDMovie], tableView:UITableView, delegate:UITableViewDelegate) {
        self.movies = movies
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        tableView.register(cellType: FavoriteMovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = delegate
        tableView.reloadData()
        
    }
    
    func updateMovies(_ movies:[CDMovie]){
        self.movies = movies
        self.tableView?.reloadData()
    }
    
}

extension FavoriteMoviesDataSource: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FavoriteMovieTableViewCell.self)
        
        let movie = movies[indexPath.row]
        cell.setup(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            let movie = self.movies[indexPath.row]
            movies.remove(at: indexPath.row)
            CDMovieDAO.unfavoriteMovie(movie: movie)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}
