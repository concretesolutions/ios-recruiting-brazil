//
//  MoviesViewController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 09/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Combine

class MoviesViewController: SearchBarViewController {
    private let network = Network.shared
    private let gridView = MovieGridView.init()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>?
    lazy var moviesViewModel: MovieViewModel = {
        return MovieViewModel.shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateDataSource()
        configurateDelegate()
        moviesViewModel.loadAllMovies()
        addObservers()
        gridView.collectionView.addEmptyState(state: .loading)
    }
    
    private func configurateDelegate() {
        gridView.collectionView.delegate = self
    }
    override func loadView() {
        view = gridView
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(changedMovies), name: .updatedMovies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorInLoadMovies), name: .networkError, object: nil)
        network.observerNetwork { (status) in
            if status == .connected {
                self.gridView.collectionView.addEmptyState(state: .loading)
                self.moviesViewModel.loadAllMovies()
            } else {
                self.errorInLoadMovies()
            }
        }
    }
    
    @objc
    func errorInLoadMovies() {
        gridView.collectionView.addEmptyState(state: .networkError)
    }
    
    @objc
    func changedMovies() {
        self.loadItems(withAnimation: true)
    }
}

//MARK: - Functions to CollectionView - DataSource
extension MoviesViewController {
    
    private func configurateDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>.init(collectionView: gridView.collectionView , cellProvider: { (collection, indexPath, movie) -> UICollectionViewCell? in
            guard let cell = collection.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            else { return UICollectionViewCell() }
            cell.fill(withMovie: movie)
            return cell
        })
    }
    
    private func snapshotDataSource() -> NSDiffableDataSourceSnapshot<Section, Movie> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        snapshot.appendSections([.first])
        let allMovies = moviesViewModel.movies
        let state: EmptyState = allMovies.count == 0 ? .noData : .none
        gridView.collectionView.addEmptyState(state: state)
        snapshot.appendItems(allMovies)
        return snapshot
    }
    
    private func snapshotFilteredDataSource() -> NSDiffableDataSourceSnapshot<Section, Movie> {
        guard var snapshot = dataSource?.snapshot() else {return snapshotDataSource()}
        snapshot.deleteAllItems()
        snapshot.appendSections([.first])
        let filtered = moviesViewModel.filteredMovies
        let state: EmptyState = filtered.count == 0 ? .noResults : .none
        gridView.collectionView.addEmptyState(state: state)
        snapshot.appendItems(filtered)
        return snapshot
    }
    
    private func loadItems(withAnimation animation: Bool) {
        DispatchQueue.main.async {
            if self.network.status == .connected {
                guard let dtSource = self.dataSource else { return }
                if self.searchIsFiltered {
                    dtSource.apply(self.snapshotFilteredDataSource(),
                                   animatingDifferences: animation)
                }else {
                    dtSource.apply(self.snapshotDataSource(),
                                   animatingDifferences: animation)
                }
            } else {
                self.errorInLoadMovies()
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = MovieDetailsViewController.init()
        detailsController.hidesBottomBarWhenPushed = true
        moviesViewModel.selectMovie(index: indexPath.row, isFiltered: searchIsFiltered)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}

//MARK: - Function to search bar
extension MoviesViewController {
    override func updateSearchResults(for searchController: UISearchController) {
        super.updateSearchResults(for: searchController)
        guard let text = searchController.searchBar.text else { return }
        moviesViewModel.filterMovies(withText: text)
        loadItems(withAnimation: true)
    }
}
