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
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateDataSource()
    }
    
    override func loadView() {
        view = gridView
    }
}

//MARK: - Functions to CollectionView - DataSource
extension MoviesViewController {
    enum Section {
        case first
    }
    
    private func configurateDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Int>.init(collectionView: gridView.collectionView , cellProvider: { (collection, indexPath, value) -> UICollectionViewCell? in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
            cell.backgroundColor = .red
            return cell
        })
        loadItems(withAnimation: false)
    }
    
    private func snapshotDataSource() -> NSDiffableDataSourceSnapshot<Section, Int> {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Int>()
        snapshot.appendSections([.first])
        snapshot.appendItems(Array(1...10))
        return snapshot
    }
    
    private func loadItems(withAnimation animation: Bool) {
        dataSource.apply(snapshotDataSource(), animatingDifferences: animation)
    }
}
