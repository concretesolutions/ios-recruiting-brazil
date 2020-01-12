//
//  UICollectionViewCell+Identifiable.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier,
                                                  for: indexPath) as? T else {
            preconditionFailure("should dequeue registered cell")
        }
        return cell
    }
}
