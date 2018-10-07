//
//  MoviesListProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol MoviesListViewProtocol: class {
    var errorIsShowing: Bool { get }
    func addSection(in index: Int)
    func showLoading()
    func hideLoading()
    func showCollectionView()
    func hideCollectionView()
    func showErrorView()
    func hideErrorView()
    func showErrorLoading()
    func hideErrorLoading()
    func show(with vc: UIViewController)
}
