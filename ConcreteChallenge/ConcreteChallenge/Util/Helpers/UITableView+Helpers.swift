//
//  UITableViewCell+Identifiable.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier,
                                             for: indexPath) as? T else {
            preconditionFailure("TableView should dequeue the same type as registered")
        }
        return cell
    }
}
