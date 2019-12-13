//
//  MovieViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

protocol MoviesVC: UIViewController, DataFetchDelegate, MoviesDelegate {
    associatedtype T: GenericDelegate
    associatedtype G: MovieViewModel
    var delegate: T {get set}
    var movieViewModel: G {get set}
}

extension MoviesVC {
    func setup<T>(with dataSource: GenericDataSource<T>) {
        dataSource.dataFetchDelegate = self
        delegate.moviesDelegate = self
        movieViewModel.dataSource = dataSource as? Self.G.T
    }
}
