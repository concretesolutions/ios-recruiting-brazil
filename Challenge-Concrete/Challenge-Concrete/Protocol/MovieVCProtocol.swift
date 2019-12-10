//
//  MovieViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

protocol MoviesVC: UIViewController, DataFetchDelegate, MoviesDelegate {
    associatedtype A: GenericDataSource<Movie>
    associatedtype T: MovieData
    associatedtype G: MovieViewModel
    var dataSource: A {get}
    var delegate: T {get set}
    var movieViewModel: G {get set}
}

extension MoviesVC {
    func setupDelegateDataSource() {
        dataSource.dataFetchDelegate = self
        delegate.moviesDelegate = self
        movieViewModel.dataSource = dataSource
    }
}
