//
//  MoviesCollectionViewManager.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoritesMoviesTableViewManager: NSObject {
    
    private var presenterProtocol: FavoritesMoviesListPresenterProtocol?
        
    init(with presenter: FavoritesMoviesListPresenterProtocol) {
        presenterProtocol = presenter
    }
}

//MARK: - TableView Delegate -
extension FavoritesMoviesTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

//MARK: - TableView DataSource -
extension FavoritesMoviesTableViewManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenterProtocol?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = presenterProtocol?.movies[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(with: FavoriteMovieCell.self, for: indexPath)
        cell.model = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenterProtocol?.openMovieDetail(to: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.init(style: .destructive, title: "Desfavoritar") { _,_,_ in self.presenterProtocol?.deleteItem(in: indexPath) }
        return UISwipeActionsConfiguration.init(actions: [deleteAction])
    }
}
