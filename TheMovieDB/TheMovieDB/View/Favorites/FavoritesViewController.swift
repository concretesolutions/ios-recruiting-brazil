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
    
    enum Section {
        case first
    }
    
    private let favoritesView = FavoritesView.init()
    lazy var moviesViewModel: MovieViewModel = {
        return MovieViewModel.shared
    }()
    private var dataSource: UITableViewDiffableDataSource<Section,Movie>?

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
        dataSource = UITableViewDiffableDataSource<Section, Movie>.init(tableView: favoritesView.tableView, cellProvider: { (tableView, indexPath, movie) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesView.identifier, for: indexPath)
            cell.textLabel?.text = movie.title
            cell.textLabel?.textColor = .textColor
            cell.imageView?.image = UIImage.init(named: "placeholder-movies")
            cell.imageView?.downloadImage(withPath: movie.posterPath, withDimension: .w92)
            cell.imageView?.border(withRadius: 2.0, andColor: .black)
            cell.backgroundColor = .clear
            return cell
            })
    
        loadItems(withAnimation: false)
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

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

