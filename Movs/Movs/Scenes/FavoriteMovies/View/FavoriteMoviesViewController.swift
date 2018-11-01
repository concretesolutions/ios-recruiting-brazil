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
    
    // MARK: = Setup
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Favoritos"
        setFilterButton()
    }
    
    // Add a Filter button and icon into the navigation bar
    private func setFilterButton() {
        let filterFavorite = UIButton(type: .custom)
        filterFavorite.setImage(UIImage(named: "filter_icon"), for: .normal)
        filterFavorite.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        filterFavorite.addTarget(self, action: #selector(self.filterMovies), for: .touchUpInside)
        let filterFavoritesButton = UIBarButtonItem(customView: filterFavorite)
        navigationItem.setRightBarButton(filterFavoritesButton, animated: true)
    }
    
    @objc func filterMovies() {
        self.performSegue(withIdentifier: "filterMovies", sender: nil)
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
