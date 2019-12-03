//
//  MoviesCollectionDatasource.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MoviesCollectionDataSource: NSObject {
    var items: [String] = []
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    
    required init(items: [String], collectionView: UICollectionView, delegate: UICollectionViewDelegate) {
        super.init()
        self.items = items
        self.collectionView = collectionView
        self.delegate = delegate
        
        collectionView.register(MoviesCollectionViewCell.nib(), forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier())
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self.delegate
        self.collectionView?.reloadData()
    }
}

extension MoviesCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier(), for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        let item = items[indexPath.item]
        cell.setup(item: item)
        return cell
    }
}
