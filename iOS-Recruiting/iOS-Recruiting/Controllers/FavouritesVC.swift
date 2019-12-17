//
//  FavouritesVC.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 17/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

class FavouritesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    internal var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.refreshControl.addTarget(self, action: #selector(self.refreshList), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView()
    }
    
    internal lazy var viewModel: PopularMoviesViewModel = {
        let vm = PopularMoviesViewModel()
        vm.setView(self)
        return vm
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func refreshList() {
        if !self.tableView.isDragging {
            self.refreshAction()
        }
    }
    
    private func refreshAction() {
        self.viewModel.getPopularMovies(reload: true)
    }
    
    private func getMovie(indexPath: IndexPath) -> Movie? {
        let movies = self.viewModel.movieList ?? []
        
        guard movies.indices.contains(indexPath.row) else {
            return nil
        }
        
        return movies[indexPath.row]
    }
    
}
extension FavouritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension FavouritesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextualActions: [UIContextualAction] = []
        let remove = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, handler) in
            if self.viewModel.favourites.indices.contains(indexPath.row) {
                let movie = self.viewModel.favourites[indexPath.row]
                let cookieName = CookieName.movie.movieNameId(id: movie.id ?? 0)
                Cookie.shared.delete(cookieName)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        }
        contextualActions.append(remove)
        
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: contextualActions)
        swipeActionsConfiguration.performsFirstActionWithFullSwipe = true
        return swipeActionsConfiguration
    }
}

extension FavouritesVC: PopularMoviesDelegate {
    
    func reloadData() {
        
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }

       
        self.tableView.reloadData()
    }
    
    
     func showTableError(type: errorType) {
        switch type {
        case .empty:
            let error = ErrorView()
            error.configure(type: type)
            error.delegate = self
            self.tableView.backgroundView = error
        default:
            self.tableView.backgroundView = nil
        }
    }
}


extension FavouritesVC: ErrorDelegate {
    
    func retry() {
        self.tableView.backgroundView = nil
        self.refreshList()
    }

}


