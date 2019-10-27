//
//  UIView+translatesAutoresizingMaskIntoConstraints.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

extension UIView {
    static func translatesAutoresizingMaskIntoConstraints(_ translates: Bool = false, to views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = translates
        }
    }
}
