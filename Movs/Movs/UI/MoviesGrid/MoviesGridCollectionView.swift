//
//  MoviesGridCollectionView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

// MARK: - Collection view

final class MoviesGridCollectionView: UICollectionView {}
extension MoviesGridCollectionView: ViewCode {
    
    func design() {
        self.register(MoviesGridCell.self, forCellWithReuseIdentifier: MoviesGridCell.identifier)
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        self.dragInteractionEnabled = true
    }
}
