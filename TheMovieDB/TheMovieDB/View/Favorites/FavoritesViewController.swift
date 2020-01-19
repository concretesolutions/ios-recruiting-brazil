//
//  FavoritesViewController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 07/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Combine
import Stevia

class FavoritesViewController: UIViewController {
     
    private let favoritesView = FavoritesView.init()
    lazy var moviesViewModel: MovieViewModel = {
        return MovieViewModel.shared
    }()
    private var dataSource: MovieTableViewDataSource?
    private var subscribers = [AnyCancellable?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourceTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadItems(withAnimation: true)
    }
    
    override func loadView() {
        view = favoritesView
    }
    
    public func dataSourceTableView() {
        dataSource = MovieTableViewDataSource.init(tableView: favoritesView.tableView, cellProvider: { (tableView, indexPath, movie) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UITableViewCell()}
            cell.fill(withMovie: movie)
            
            self.subscribers.append(movie.notification.receive(on: DispatchQueue.main).sink { (_) in
                if !movie.isFavorite {
                    self.removeFavoriteMovie(movie)
                }
            })
            
            return cell
            })
        loadItems(withAnimation: false)
    }
    
    private func removeFavoriteMovie(_ movie: Movie) {
        DispatchQueue.main.async {
            guard var snapshot = self.dataSource?.snapshot() else { return }
            snapshot.deleteItems([movie])
            self.dataSource?.apply(snapshot,animatingDifferences: true)
        }
    }
    
    private func snapshotDataSource() -> NSDiffableDataSourceSnapshot<Section,Movie> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        snapshot.appendSections([.first])
        snapshot.appendItems(moviesViewModel.movies.filter({ $0.isFavorite }))
        return snapshot
    }
    
    private func loadItems(withAnimation animation: Bool) {
        DispatchQueue.main.async {
            guard let dtSource = self.dataSource else { return }
            dtSource.apply(self.snapshotDataSource(), animatingDifferences: animation)
        }
    }
}

class MovieTableViewDataSource: UITableViewDiffableDataSource<Section, Movie> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            MovieViewModel.shared.changeFavorite(at: indexPath.row)
         }
    }
}


