//
//  UICollectionView.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(cell: UICollectionViewCell.Type) {
        let identifier = String(describing: cell.self)
        self.register(UINib.init(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}
