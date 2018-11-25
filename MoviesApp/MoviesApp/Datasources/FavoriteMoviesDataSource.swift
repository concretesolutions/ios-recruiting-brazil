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
    var isFiltering:Bool
    
    weak var tableView:UITableView?
    weak var delegate:FavoriteMoviesTableDelegate?
    
    required init(movies:[CDMovie], filtering:Bool = false, tableView:UITableView, delegate:FavoriteMoviesTableDelegate) {
        self.movies = movies
        self.tableView = tableView
        self.delegate = delegate
        self.isFiltering = filtering
        
        super.init()
        delegate.dataSource = self
        delegate.isFiltering = filtering
        tableView.register(cellType: FavoriteMovieTableViewCell.self)
        tableView.register(cellType: RemoveFilterTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = delegate
        tableView.reloadData()
        
    }
    
    func resetFilter(){
        self.isFiltering = false
        self.updateMovies(CDMovieDAO.fetchAll())
    }
    
    func updateMovies(_ movies:[CDMovie]){
        self.movies = movies
        self.tableView?.reloadData()
    }
    
}

extension FavoriteMoviesDataSource: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? movies.count + 1 : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && isFiltering{
            let headerCell = tableView.dequeueReusableCell(for: indexPath, cellType: RemoveFilterTableViewCell.self)
            return headerCell
        }
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FavoriteMovieTableViewCell.self)

        let movie = isFiltering ? movies[indexPath.row - 1] : movies[indexPath.row]
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
