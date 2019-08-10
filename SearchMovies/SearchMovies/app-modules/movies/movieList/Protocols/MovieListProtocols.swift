//
//  MovieListProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToMovieListPresenterProtocol:class {
    var view:PresenterToMovieListViewProtocol?{get set}
    var iteractor:PresenterToMovieListIteractorProtocol?{get set}
    var route:PresenterToMovieListRouterProtocol?{get set}
    func loadMovies(page:Int)
    func loadGenrers()
    func loadFavorites()
    func existsInFavorites(movieId:Int)
   
}

protocol PresenterToMovieListIteractorProtocol:class {
    var presenter:IteractorToMovieListPresenterProtocol? {get set}
    func loadMovies(page:Int)
    func loadGenrers()
    func loadFavorites()
   
}

protocol PresenterToMovieListRouterProtocol:class {
    func pushToScreen(_ view: MovieListViewController, segue: String, param:AnyObject?)
}

protocol IteractorToMovieListPresenterProtocol:class {
    func returnMovies(movies:[MovieListData], moviesTotal:Int)
    func returnMoviesError(message:String)
    func returnLoadGenrers(genres:[GenreData])
    func returnLoadGenrersError(message:String)
    func returnExistsInFavorites(isFavorite:Bool)
    func returnLoadFavorites(favoritemovies:[FavoritesDetailsData])
}

protocol PresenterToMovieListViewProtocol:class {
    func returnMovies(movies:[MovieListData], moviesTotal: Int)
    func returnMoviesError(message:String)
    func returnLoadGenrers(genres:[GenreData])
    func returnLoadGenrersError(message:String)
    func returnExistsInFavorites(isFavorite:Bool)
}
