//
//  UITableView+Register.swift
//  Movs
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.className)
    }
}
