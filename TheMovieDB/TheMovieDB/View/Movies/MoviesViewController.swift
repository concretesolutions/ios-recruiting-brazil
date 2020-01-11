//
//  MoviesViewController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 09/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewController: UIViewController {
    private let gridView = MovieGridView.init()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    lazy var moviesViewModel: MovieViewModel = {
        return MovieViewModel.shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateDataSource()
        moviesViewModel.fetchMovies()
        addObservers()
    }
    
    override func loadView() {
        view = gridView
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(changedMovies), name: Notification.moviesUpdated.name, object: nil)
    }
    
    @objc
    func changedMovies() {
        loadItems(withAnimation: true)
    }
}

//MARK: - Functions to CollectionView - DataSource
extension MoviesViewController {
    enum Section {
        case first
    }
    
    private func configurateDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>.init(collectionView: gridView.collectionView , cellProvider: { (collection, indexPath, movie) -> UICollectionViewCell? in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
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
    
    private func loadItems(withAnimation animation: Bool) {
        dataSource.apply(snapshotDataSource(), animatingDifferences: animation)
    }
}
