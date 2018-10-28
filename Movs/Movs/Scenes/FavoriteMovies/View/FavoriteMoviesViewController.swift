//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit
import CoreData

protocol FavoriteMoviesDisplayLogic {
    func displayMovies(viewModel: FavoriteMoviesModel.ViewModel.Success)
    func displayError(viewModel: FavoriteMoviesModel.ViewModel.Error)
}

class FavoriteMoviesViewController: UIViewController, UITableViewDelegate {
    
    let favoritesWorker = FavoriteMoviesWorker()
    var interactor: FavoriteMoviesBusinessLogic!
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        
        FavoriteMoviesSceneConfigurator.inject(dependenciesFor: self)
        
//        let movie = MovieDetailed(id: 123, genres: [], title: "woww title", overview: "super overview", releaseDate: nil, posterPath: "", voteAverage: 3.0, isFavorite: true)
//        favoritesWorker.addFavoriteMovie(movie: movie)
        favoritesWorker.getFavoriteMovies()
    }
    
    // MARK: - Fetch Results delegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }

    
}

extension FavoriteMoviesViewController: FavoriteMoviesDisplayLogic {
    
    func displayMovies(viewModel: FavoriteMoviesModel.ViewModel.Success) {
        
    }
    
    func displayError(viewModel: FavoriteMoviesModel.ViewModel.Error) {
        
    }
    
    
}
