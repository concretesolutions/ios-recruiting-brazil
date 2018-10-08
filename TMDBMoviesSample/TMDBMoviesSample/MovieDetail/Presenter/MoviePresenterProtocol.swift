//
//  MoviePresenterProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol {
    func getGenreList()
    func setFavorite()
    func setupFavoriteState()
}
