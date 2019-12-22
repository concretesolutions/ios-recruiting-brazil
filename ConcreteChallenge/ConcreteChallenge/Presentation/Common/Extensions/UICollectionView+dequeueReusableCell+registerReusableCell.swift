//
//  UICollectionView+dequeueReusableCell+registerReusableCell.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<CellType: UICollectionViewCell>(forCellType cellType: CellType.Type, for indexPath: IndexPath) -> CellType {
        let cellIdentifier = String(describing: cellType)
        
        guard let dequeuedCell = self.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            fatalError("""
                No collection view cell registered for the type: \(cellIdentifier) and
                IndexPath: \(indexPath)
            """)
        }
        
        return dequeuedCell
    }
    
    func registerReusableCell<CellType: UICollectionViewCell>(forCellType cellType: CellType.Type) {
        let cellIdentifier = String(describing: cellType)
        
        self.register(cellType.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}

extension UITableView {
    func dequeueReusableCell<CellType: UITableViewCell>(forCellType cellType: CellType.Type, for indexPath: IndexPath) -> CellType {
        let cellIdentifier = String(describing: cellType)
        
        guard let dequeuedCell = self.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            fatalError("""
                No collection view cell registered for the type: \(cellIdentifier) and
                IndexPath: \(indexPath)
            """)
        }
        
        return dequeuedCell
    }
    
    func registerReusableCell<CellType: UITableViewCell>(forCellType cellType: CellType.Type) {
        let cellIdentifier = String(describing: cellType)
        self.register(cellType.self, forCellReuseIdentifier: cellIdentifier)
    }
}
