//
//  UITableView+Reusable.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension UITableView {

    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                       cellType: T.Type) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.identifier)" +
                " matching type \(cellType.self).")
        }
        return cell
    }

    final func registerCell<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }

}
