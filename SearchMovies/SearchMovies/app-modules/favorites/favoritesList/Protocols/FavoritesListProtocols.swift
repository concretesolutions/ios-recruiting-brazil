//
//  BookMarkListProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToFavoritesListPresenterProtocol:class {
    var view:PresenterToFavoritesListViewProtocol?{get set}
    var iteractor:PresenterToFavoritesListIteractorProtocol?{get set}
    var route:PresenterToFavoritesListRouterProtocol?{get set}
    func loadMovies(page:Int)
    func loadGenrers()
}

protocol PresenterToFavoritesListIteractorProtocol:class {
    var presenter:IteractorToFavoritesListPresenterProtocol? {get set}
    func loadMovies(page:Int)
    func loadGenrers()
}

protocol PresenterToFavoritesListRouterProtocol:class {
    func pushToScreen(_ view: FavoritesListViewController, segue: String, param:AnyObject?)
}

protocol IteractorToFavoritesListPresenterProtocol:class {
    func returnMovies(movies:[MovieListData], moviesTotal:Int)
    func returnMoviesError(message:String)
    func returnLoadGenrers(genres:[GenreData])
    func returnLoadGenrersError(message:String)
}

protocol PresenterToFavoritesListViewProtocol:class {
    func returnMovies(movies:[MovieListData], moviesTotal: Int)
    func returnMoviesError(message:String)
    func returnLoadGenrers(genres:[GenreData])
    func returnLoadGenrersError(message:String)
}
