//
//  ReusableCell.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 15/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

protocol ReusableCell {}

extension ReusableCell {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableCell {}
extension UICollectionViewCell: ReusableCell {}

extension UITableView {
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reusableIdentifier)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: Cell.reusableIdentifier, for: indexPath
        ) as? Cell else { fatalError("Fatal error for cell at \(indexPath)") }

        return cell
    }
}

extension UICollectionView {
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reusableIdentifier)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: Cell.reusableIdentifier, for: indexPath
        ) as? Cell else { fatalError("Fatal error for cell at \(indexPath)") }

        return cell
    }
}
