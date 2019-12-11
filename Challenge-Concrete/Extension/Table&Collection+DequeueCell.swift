//
//  Table&Collection+DequeueCell.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: AnyObject>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: "\(T.self)")
    }
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
}

extension UICollectionView {
    func register<T: AnyObject>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: "\(T.self)")
    }
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }
}
