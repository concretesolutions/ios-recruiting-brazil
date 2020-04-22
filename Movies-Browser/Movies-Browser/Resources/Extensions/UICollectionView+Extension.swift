//
//  UICollectionView+Extension.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 20/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

/// Enum to help organize the set of Identifiers for UICollectionView
enum CollectionViewCell: String {
    case movieCell = "MovieCollectionViewCell"
}

extension UICollectionView {
    /// Streamlined method to register UICollectionViewCell UINib to UICollectionView
    func registerCellForType(_ type: CollectionViewCell){
        self.register(UINib(nibName: type.rawValue, bundle: nil), forCellWithReuseIdentifier: type.rawValue)
    }
}
