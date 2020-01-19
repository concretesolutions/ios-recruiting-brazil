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
    private let gridView = MovieGridView.init()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>?
    lazy var moviesViewModel: MovieViewModel = {
        return MovieViewModel.shared
    }()
    var subscriber: [AnyCancellable?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateDataSource()
        configurateDelegate()
        moviesViewModel.fetchMovies()
        addObservers()
    }
    
    private func configurateDelegate() {
        gridView.collectionView.delegate = self
    }
    override func loadView() {
        view = gridView
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(changedMovies), name: Notification.moviesUpdated.name, object: nil)
    }
    
    private func cancelSubscribers() {
        subscriber.forEach({ $0?.cancel() })
        subscriber.removeAll()
    }
    
    private func cancelSubscribe(at: Int) {
        guard self.subscriber.count > (at + 1) else { return }
        self.subscriber[at]?.cancel()
        self.subscriber.remove(at: at)
    }
    
    @objc
    func changedMovies() {
        cancelSubscribers()
        self.loadItems(withAnimation: true)
    }
}

//MARK: - Functions to CollectionView - DataSource
extension MoviesViewController {
    
    private func configurateDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>.init(collectionView: gridView.collectionView , cellProvider: { (collection, indexPath, movie) -> UICollectionViewCell? in
            guard let cell = collection.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            else { return UICollectionViewCell() }
            self.cancelSubscribe(at: indexPath.row)
            self.subscriber.append(movie.notification.receive(on: DispatchQueue.main).sink { (_) in
                print("ATT Movie -> \(movie.title) = \(movie.isFavorite)")
                print("Index -> \(indexPath.row)")
                guard let currentCell = collection.cellForItem(at: indexPath) as? MovieCell else {return}
                currentCell.isFavoriteMovie(movie.isFavorite)
            })
            cell.fill(withMovie: movie)
            return cell
        })
        loadItems(withAnimation: false)
    }
    
    private func snapshotDataSource() -> NSDiffableDataSourceSnapshot<Section, Movie> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        snapshot.appendSections([.first])
        snapshot.appendItems(moviesViewModel.movies)
        return snapshot
    }
    
    private func snapshotFilteredDataSource() -> NSDiffableDataSourceSnapshot<Section, Movie> {
        guard var snapshot = dataSource?.snapshot() else {return snapshotDataSource()}
        snapshot.deleteAllItems()
        snapshot.appendSections([.first])
        snapshot.appendItems(moviesViewModel.filteredMovies)
        return snapshot
    }
    
    private func loadItems(withAnimation animation: Bool) {
        DispatchQueue.main.async {
            
            guard let dtSource = self.dataSource else { return }
            self.cancelSubscribers()
            
            if self.searchIsFiltered {
                dtSource.apply(self.snapshotFilteredDataSource(), animatingDifferences: animation)
            }else {
                dtSource.apply(self.snapshotDataSource(), animatingDifferences: animation)
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
