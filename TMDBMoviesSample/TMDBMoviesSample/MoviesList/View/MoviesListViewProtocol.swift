//
//  MoviesListProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MoviesListViewProtocol: class {
    func addSection(in index: Int)
    func showLoading()
    func hideLoading()
    func showCollectionView()
    func hideCollectionView()
}
