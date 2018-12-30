//
//  ReusableCell.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit

// If a UIView is a ReusableView, then have a reuseIdentifier
protocol ReusableView {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// If a view loadable by a 'Nib', then have a 'nibName'
protocol NibLoadableView {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
