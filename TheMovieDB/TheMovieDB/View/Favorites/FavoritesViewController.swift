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
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourceTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadItems(withAnimation: true)
        favoritesView.tableView.delegate = self
    }
    
    override func loadView() {
        view = favoritesView
    }
    
    public func dataSourceTableView() {
        dataSource = MovieTableViewDataSource.init(tableView: favoritesView.tableView, cellProvider: { (tableView, indexPath, movie) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UITableViewCell()}
            cell.fill(withMovie: movie)
            return cell
            })
        loadItems(withAnimation: false)
    }
    
    private func snapshotDataSource() -> NSDiffableDataSourceSnapshot<Section,Movie> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        snapshot.appendSections([.first])
        let movies = moviesViewModel.movies.filter({ $0.isFavorite })
        let state: EmptyState = movies.count == 0 ? .noData : .none
        favoritesView.tableView.addEmptyState(state: state)
        snapshot.appendItems(movies)
        return snapshot
    }
    
    private func loadItems(withAnimation animation: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let dtSource = self.dataSource else { return }
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
            guard let favoriteMovie = MovieViewModel.shared.favoriteMovie(at: indexPath.row)
                else { return }
            removeMovieInDataSource(favoriteMovie, inTableView: tableView)
            MovieViewModel.shared.changeFavorite(at: indexPath.row)
         }
    }
    
    private func removeMovieInDataSource(_ movie: Movie, inTableView table: UITableView) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var snap  = self.snapshot()
            snap.deleteItems([movie])
            self.apply(snap,animatingDifferences: true)
            if snap.numberOfItems(inSection: Section.first) > 0 {
                table.addEmptyState(state: .none)
            } else {
                table.addEmptyState(state: .noData)
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsController = MovieDetailsViewController.init()
        detailsController.hidesBottomBarWhenPushed = true
        MovieViewModel.shared.selectMovie(index: indexPath.row)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
