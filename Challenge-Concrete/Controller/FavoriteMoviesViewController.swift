//
//  FavoriteMoviesViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit
import CoreData

class FavoriteMoviesViewController: UIViewController, MoviesVC {

    var dataSource = MovieDataSource()
    var delegate = MovieTableDelegate()
    var movieViewModel = FavoriteMoviesViewModel()
    let moviesView = FavoriteMoviesView()
    
    override func loadView() {
        view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        setup(with: dataSource)
        moviesView.setupTableView(delegate: delegate, dataSource: dataSource)
        movieViewModel.fetchFavoriteMovies()
    }
}

// MARK: DataFetchDelegate
extension FavoriteMoviesViewController {
    func didUpdateData() {
        DispatchQueue.main.async {
            self.moviesView.reloadTableData()
        }
    }
    
    func didFailFetchData(with error: Error) {
        print("Erro no favoritos: \(error)")
    }
}

// MARK: MoviesDelegate
extension FavoriteMoviesViewController {
    func didSelectMovie(at index: Int) {
        let movie = dataSource.data[index]
        navigationController?.pushViewController(MovieDetailViewController(), animated: true)
        print("MOVIE INDEX: \(movie.title ?? "none")")
    }
    
    func didFavoriteMovie(at index: Int, turnFavorite: Bool) {
        if !turnFavorite {
            let movie = dataSource.data[index]
            movieViewModel.remove(Int(movie.id))
        }
    }
}

extension FavoriteMoviesViewController: FavoriteMovieDelegate {
    func didAdd(_ favoriteMovie: FavoriteMovie) {
        movieViewModel.add(favoriteMovie)
    }
    
    func didRemove(favoriteMovieId: Int) {
        movieViewModel.remove(favoriteMovieId)
    }
    
    
}
