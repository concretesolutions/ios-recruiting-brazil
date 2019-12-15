//
//  MoviesDelegate.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

protocol MoviesDelegate: AnyObject {
    func didSelectMovie(at index: Int)
    func didFavoriteMovie(at index: Int)
}

extension MoviesDelegate {
    func didFavoriteMovie(at index: Int) { }
}
