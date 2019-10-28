//
//  FavoritesListViewController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {

    static let FAVORITES_CELL_IDENTIFIER = "favoritesCell"
    
    private lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(FavoriteMovieTableCell.self, forCellReuseIdentifier: FavoritesListViewController.FAVORITES_CELL_IDENTIFIER)
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loadingIndicator
    }()
    
    private lazy var errorView = MessageView()
    
    var viewModel: FavoritesListViewModel
    
    init(with viewModel: FavoritesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Movies"
        self.view.backgroundColor = .systemBackground
        self.errorView.addAsSubview(to: self.view)

        self.view.addSubviews([self.tableView, self.loadingIndicator])
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.viewModel.delegate = self
        self.viewModel.fetchFavorites()
    }
    
}

extension FavoritesListViewController: FavoritesListDelegate {
    func favoritesListUpdated() {
        self.errorView.toggle(show: false)
        self.tableView.reloadData()
    }
    
    func toggleLoading(_ isLoading: Bool) {
        if isLoading {
            self.loadingIndicator.startAnimating()
        } else {
            self.loadingIndicator.stopAnimating()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.alpha = isLoading ? 0 : 1
        }
    }
    
    func errorFetchingMovies(error: APIError) {
        self.errorView.viewModel = MessageViewModel(withImageNamed: "error", andMessage: error.rawValue)
    }
}

extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesListViewController.FAVORITES_CELL_IDENTIFIER, for: indexPath)
        
        if let cellViewModel = self.viewModel.getViewModelForCell(at: indexPath), cell is FavoriteMovieTableCell {
            (cell as! FavoriteMovieTableCell).viewModel = cellViewModel
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectMovie(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavoriteAction = UIContextualAction(style: .destructive, title: "Unfavorite") { (_, _, completionHandler) in
            self.viewModel.unfavoriteMovie(at: indexPath, completion: completionHandler)
        }
        let actionsConfiguration = UISwipeActionsConfiguration(actions: [unfavoriteAction])
//        actionsConfiguration.performsFirstActionWithFullSwipe = true
        return actionsConfiguration
    }
    
}
