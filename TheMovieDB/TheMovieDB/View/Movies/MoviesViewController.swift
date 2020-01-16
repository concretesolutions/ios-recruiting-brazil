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

class MoviesViewController: UIViewController {
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
    
    @objc
    func changedMovies() {
        subscriber.forEach({ $0?.cancel() })
        subscriber.removeAll()
        self.loadItems(withAnimation: true)
    }
}

//MARK: - Functions to CollectionView - DataSource
extension MoviesViewController {
    enum Section {
        case first
    }
    
    private func configurateDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>.init(collectionView: gridView.collectionView , cellProvider: { (collection, indexPath, movie) -> UICollectionViewCell? in
            guard let cell = collection.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            else { return UICollectionViewCell() }
            
            self.subscriber.append(movie.notification.receive(on: DispatchQueue.main).sink { (_) in
                cell.fill(withMovie: movie)
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
    
    private func loadItems(withAnimation animation: Bool) {
        DispatchQueue.main.async {
            guard let dtSource = self.dataSource else { return }
            dtSource.apply(self.snapshotDataSource(), animatingDifferences: animation)
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = MovieDetailsViewController.init()
        moviesViewModel.selectMovie(index: indexPath.row)
        self.navigationController?.pushViewController(detailsController, animated: true)
        
    }
}
