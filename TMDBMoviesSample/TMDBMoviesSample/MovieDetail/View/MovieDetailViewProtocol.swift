//
//  MovieDetailViewProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MovieDetailViewProtocol: class {
    var model: MovieDetailModel? { get }
    func showBackdropLoading()
    func hideBackdropLoading()
    func showGenreLoading()
    func hideGenreLoading()
}
