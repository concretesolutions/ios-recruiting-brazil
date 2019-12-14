//
//  UICollectionView+Reusable.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension UICollectionView {

    final func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath, cellType: T.Type) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.identifier)" +
                " matching type \(cellType.self).")
        }
        return cell
    }

    final func registerCell<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.identifier)
    }

}
