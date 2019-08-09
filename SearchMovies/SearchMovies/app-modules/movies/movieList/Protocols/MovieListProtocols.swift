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
}

protocol PresenterToMovieListIteractorProtocol:class {
    var presenter:IteractorToMovieListPresenterProtocol? {get set}
    func loadMovies(page:Int)
}

protocol PresenterToMovieListRouterProtocol:class {
    func pushToScreen(_ view: MovieListViewController, segue: String, param:AnyObject?)
}

protocol IteractorToMovieListPresenterProtocol:class {
    func returnMovies(movies:[MovieListData])
    func returnMoviesError(message:String)
}

protocol PresenterToMovieListViewProtocol:class {
    func returnMovies(movies:[MovieListData])
    func returnMoviesError(message:String)
}
