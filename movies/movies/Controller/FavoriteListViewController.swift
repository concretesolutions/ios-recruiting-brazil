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
    
    var viewModel: FavoriteListViewModel!
    var screen: FavoriteListViewControllerScreen!
    
    var query = PassthroughSubject<String?, Never>() // String written in search bar
    
    override func loadView() {
        viewModel = FavoriteListViewModel(query: query.eraseToAnyPublisher())
        
        screen = FavoriteListViewControllerScreen(frame: UIScreen.main.bounds, state: viewModel.$state.eraseToAnyPublisher())
        screen.tableView.dataSource = self
        screen.tableView.delegate = self
        
        self.view = screen
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = search
        self.navigationItem.searchController!.searchBar.delegate = self // Set the serach bar delegate to this
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Favorites"
        self.query.send("")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.viewModel.$movieCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.perform(#selector(self?.loadTableView), with: nil, afterDelay: 1.0)
            }
    }
    
    @objc func loadTableView() {
        self.screen.tableView.reloadData()
    }
}

// MARK: - SearchBar
extension FavoriteListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.query.send(searchBar.text) // Send changes in query string value
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.query.send(searchBar.text) // Send changes in query string value
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
        
        cell.viewModel = cellViewModel
        
        return cell
    }
}

// MARK: - Table View Delegate
extension FavoriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
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
