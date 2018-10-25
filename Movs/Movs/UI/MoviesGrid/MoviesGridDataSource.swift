//
//  MoviesGridDataSource.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MoviesGridDataSource: NSObject, UICollectionViewDataSource {
    
    var items:[MoviesGridCell.Data]
    
    init(items:[MoviesGridCell.Data]? = nil) {
        self.items = items ?? []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesGridCell.identifier, for: indexPath) as? MoviesGridCell else {
            return UICollectionViewCell()
        }
        cell.setupView()
        let data = self.items[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}
