//
//  MoviesViewControllerProtocol.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

protocol MoviesViewControllerProtocol {
    func changeScreenStatus(type: MoviesViewController.ScreenStatus)
    func setMoviesList(movies: MovieListResponse)
    func appendMoviesList(movies: MovieListResponse)
    func setError(message: String)
}
