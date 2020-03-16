//
//  FavoritesTableViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, Alerts {

    // MARK: - Properties
    
    private let reuseIdentifier = "favcell"
    private var viewModel: FavoritesListViewModel?
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()

    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        viewModel = FavoritesListViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchFavorites()
        setUpView()
    }
    
    deinit {
        guard viewModel != nil else {
            return
        }
        viewModel = nil
    }

    // MARK: - Class Functions
    
    private func setUpView() {
        if let navTopItem = navigationController?.navigationBar.topItem {
            navTopItem.titleView = .none
            navTopItem.title = "Favorites"
        }
        view.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
    }
    
    private func deleteMovie(index: IndexPath) {
        viewModel?.deleteFavorite(line: index.row, completion: { success in
            if success {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadMovies"), object: nil)
                    self.tableView.reloadData()
                }
            } else {
                let title = "Alerta"
                let action = UIAlertAction(title: "OK", style: .default)
                self.displayAlert(with: title , message: kDeleteFavoriteError, actions: [action])
            }
        })
    }
    
    // MARK: - TableView DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel?.currentCount, count > 0 {
            return count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavoritesTableViewCell
        guard let tableViewModel = viewModel else {
            cell.setCell(with: .none)
            return cell
        }
        if tableViewModel.currentCount > 0 {
            cell.setCell(with: tableViewModel.movie(at: indexPath.row))
        } else {
            cell.setCell(with: .none)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let action = UIAlertAction(title: "Desfavoritar", style: .destructive) { (result) in
                self.deleteMovie(index: indexPath)
            }
            displayAlert(with: "Alerta", message: kUnfavoriteConfirmation, actions: [action])
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
         return "Unfavorite"
    }

}

// MARK: - FavoritesListViewModelDelegate

extension FavoritesTableViewController: FavoritesListViewModelDelegate {
    func onFetchCompleted() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: "Alerta" , message: reason, actions: [action])
    }
    
    
}
