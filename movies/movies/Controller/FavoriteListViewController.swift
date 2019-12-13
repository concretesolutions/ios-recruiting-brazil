//
//  FavoriteListViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

class FavoriteListViewController: UIViewController {
    let viewModel: FavoriteListViewModel = FavoriteListViewModel()
    let screen: FavoriteListViewControllerScreen = FavoriteListViewControllerScreen(frame: UIScreen.main.bounds)
    
    // Cancellables
    var stateSubscriber: AnyCancellable?
    var movieCountSubscriber: AnyCancellable?
    var tabBarSelectSubscriber: AnyCancellable?
    
    override func loadView() {
        self.view = screen
        
        self.setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupScreen()
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Favorites"
        self.navigationItem.searchController = SearchController() // Set custom search controller as navigation item search
        
        if let searchController = self.navigationItem.searchController as? SearchController {
            self.viewModel.bindQuery(searchController.publisher) // Use search controller as query publisher
        }
    }
    
    func setupScreen() {
        // Binds view model state to view state
        stateSubscriber = viewModel.$state
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self.screen)
        
        // Set table view data source and delegate
        screen.setupTableView(controller: self)
        
        // Update table view when movie count changes
        movieCountSubscriber = self.viewModel.$movieCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.perform(#selector(self?.reloadTableView), with: nil, afterDelay: 0.5)
            }
        
        // Scroll to top when view controller is selected on tab bar
        self.subscribeToTabSelection(cancellable: &tabBarSelectSubscriber)
    }
    
    @objc func reloadTableView() {
        self.screen.reloadTableView()
    }
}

// MARK: - Table View Data Source
extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movieCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieTableViewCell", for: indexPath) as? FavoriteMovieTableViewCell else {
            return UITableViewCell()
        }
        guard let cellViewModel = self.viewModel.viewModelForMovie(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setViewModel(cellViewModel)
        
        return cell
    }
}

// MARK: - Table View Delegate
extension FavoriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieViewModel = self.viewModel.viewModelForMovieDetails(at: indexPath.row) else { return }
        
        let detailsView = MovieDetailsViewController(viewModel: movieViewModel)
        navigationController?.pushViewController(detailsView, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.viewModel.toggleFavoriteMovie(at: indexPath.row)
            tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
        }
    }
}
