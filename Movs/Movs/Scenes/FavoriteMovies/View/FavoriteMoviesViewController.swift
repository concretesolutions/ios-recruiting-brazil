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
    var filteredMovies = [FavoriteMoviesModel.FavoriteMovie]()
    let favoriteMovieCellReuseIdentifier = "FavoriteMovieCell"
    var filteringMovies: FilterFavoritesViewController?
    var isFilteringMovies: Bool = false
    
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
        filteringMovies = (UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "filterFavoriteMovies") as! FilterFavoritesViewController)
        filteringMovies?.viewController = self
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Favoritos"
        setFilterButtonWith(icon: "filter_icon")
    }
    
    // Add a Filter button and icon into the navigation bar
    private func setFilterButtonWith(icon: String) {
        let filterFavorite = UIButton(type: .custom)
        filterFavorite.setImage(UIImage(named: icon), for: .normal)
        filterFavorite.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        filterFavorite.addTarget(self, action: #selector(self.filterMovies), for: .touchUpInside)
        let filterFavoritesButton = UIBarButtonItem(customView: filterFavorite)
        navigationItem.setRightBarButton(filterFavoritesButton, animated: true)
    }
    /// Action for Filter Button
    @objc func filterMovies() {
        if isFilteringMovies {
            isFilteringMovies = false
            setFilterButtonWith(icon: "filter_icon")
            tableView.reloadData()
        } else {
            navigationController?.present(filteringMovies!, animated: true, completion: nil)
        }
    }

}
// MARK: - Display Logic
extension FavoriteMoviesViewController: FavoriteMoviesDisplayLogic {
    
    func displayMovies(viewModel: FavoriteMoviesModel.ViewModel.Success) {
        movies = viewModel.movies
        tableView.reloadData()
    }
    
    func displayError(viewModel: FavoriteMoviesModel.ViewModel.Error) {
        let alertVC = UIAlertController(title: viewModel.title, message: viewModel.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            self.tabBarController?.selectedIndex = 0
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
// MARK: - Favorite Delegate
extension FavoriteMoviesViewController: FilterFavoritesDelegate {
   
    func moviesFiltered(movies: [FavoriteMoviesModel.FavoriteMovie]) {
        isFilteringMovies = true
        self.filteredMovies = movies
        setFilterButtonWith(icon: "no_filter_icon")
    }
    
}
