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

    var filterResetterDelegate: FilterResetter?
    
    convenience init(tableStyle:TableViewStyle) {
        self.init(frame: .zero)
        
        switch tableStyle{
        case .detailMovie:
            customDelegate = DetailMovieTableDelegate()
            customDataSource = nil
        case .favoriteMovies:
            customDelegate = FavoriteMoviesTableDelegate()
            customDataSource = FavoriteMoviesDataSource(movies: [], tableView: self, delegate: customDelegate as! FavoriteMoviesTableDelegate)
        }
        
        setupLayout()
    }
    
    func setupLayout(){
        self.backgroundColor = Palette.blue
        self.separatorStyle = .none
    }
    
}

extension MoviesTableView{
    
    func setupTableView(with movies:[CDMovie], filtering:Bool = false){
        self.customDataSource = FavoriteMoviesDataSource(movies: movies, filtering: filtering, tableView: self, delegate: customDelegate as! FavoriteMoviesTableDelegate)
    }
    
    func setupTableView(with movie:Movie, genres:[Genre]){
        self.customDataSource = DetailMovieDataSource(movie: movie, genres: genres, tableView: self, delegate: customDelegate!)
    }
    
}

extension MoviesTableView{
    
    func resetFilters(){
        filterResetterDelegate?.resetFilter()
    }
    
}
