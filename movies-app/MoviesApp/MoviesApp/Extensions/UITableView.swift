//
//  UITableView.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 04/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNibForTableViewCell<T: UITableViewCell>(_:T.Type) {
        self.register(UINib(nibName: T.reusableIdentifier, bundle: nil),
                      forCellReuseIdentifier: T.reusableIdentifier)
    }
}
