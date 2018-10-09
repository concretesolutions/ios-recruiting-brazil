//
//  MoviesListPresenterProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol FavoritesMoviesListPresenterProtocol {
    var movies: [MovieDetailModel] { get }
    func openMovieDetail(to indexPath: IndexPath)
    func deleteItem(in indexPath: IndexPath)
}
