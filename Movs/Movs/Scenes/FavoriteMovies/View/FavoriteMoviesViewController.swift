//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol FavoriteMoviesDisplayLogic {
    func displayMovies(viewModel: FavoriteMoviesModel.ViewModel.Success)
    func displayError(viewModel: FavoriteMoviesModel.ViewModel.Error)
}

class FavoriteMoviesViewController: UIViewController, UITableViewDelegate {
    
    var interactor: FavoriteMoviesBusinessLogic!
    
    @IBOutlet weak var tableView: UITableView!

    var movies = [FavoriteMoviesModel.FavoriteMovie]()
    let favoriteMovieCellReuseIdentifier = "FavoriteMovieCell"
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        FavoriteMoviesSceneConfigurator.inject(dependenciesFor: self)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         interactor.getMovies()
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Favoritos"
        navigationItem.backBarButtonItem?.title = ""
    }
    
}

extension FavoriteMoviesViewController: FavoriteMoviesDisplayLogic {
    
    func displayMovies(viewModel: FavoriteMoviesModel.ViewModel.Success) {
        movies = viewModel.movies
        tableView.reloadData()
    }
    
    // TODO: display error
    func displayError(viewModel: FavoriteMoviesModel.ViewModel.Error) {
        let alertVC = UIAlertController(title: viewModel.title, message: viewModel.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            self.tabBarController?.selectedIndex = 0
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
