//
//  FavoriteMoviesViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController, MoviesVC {

    let dataSource = MovieDataSource()
    var delegate = MovieTableDelegate()
    var movieViewModel = FavoriteMoviesViewModel()
    //let moviesView = FavoriteMoviesView()
    
    override func loadView() {
        //view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegateDataSource()
        //moviesView.setupTableView(delegate: delegate, dataSource: dataSource)
        movieViewModel.fetchTrendingMovies()
    }
}

// MARK: DataFetchDelegate
extension FavoriteMoviesViewController {
    func didUpdateData() {
        DispatchQueue.main.async {
            //self.moviesView.reloadTableData()
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
        //navigationController?.pushViewController(MovieDetailViewController(), animated: true)
        print("MOVIE INDEX: \(movie.title ?? "none")")
    }
    
    
}
