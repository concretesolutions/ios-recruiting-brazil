//
//  MoviesListProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol FavoritesMoviesListViewProtocol: class {
    func showEmptyState()
    func showTableView()
    func removeRow(in indexPath: IndexPath)
    func show(with vc: UIViewController)
}
