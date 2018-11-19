//
//  MoviesTableView.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

enum TableViewStyle{
    case detailMovie
    case favoriteMovies
}

class MoviesTableView:UITableView{
    
//    fileprivate var customDataSource:FavoriteMoviesDataSource?
//    fileprivate var customDelegate:FavoriteMoviesTableDelegate?
    
    fileprivate var customDataSource:UITableViewDataSource?
    fileprivate var customDelegate:UITableViewDelegate?

    
    convenience init(tableStyle:TableViewStyle) {
        self.init(frame: .zero)
        
        switch tableStyle{
        case .detailMovie:
            customDelegate = DetailMovieTableDelegate()
            customDataSource = nil
        case .favoriteMovies:
            customDelegate = FavoriteMoviesTableDelegate()
            customDataSource = FavoriteMoviesDataSource(movies: [], tableView: self, delegate: customDelegate!)
        }
        
        setupLayout()
    }
    
    func setupLayout(){
    }
    
    func setupTableView(with movies:[CDMovie]){
        self.customDataSource = FavoriteMoviesDataSource(movies: movies, tableView: self, delegate: customDelegate!)
    }
    
    func setupTableView(with movie:Movie, genres:[Genre]){
        self.customDataSource = DetailMovieDataSource(movie: movie, genres: genres, tableView: self, delegate: customDelegate!)
    }
    
}
