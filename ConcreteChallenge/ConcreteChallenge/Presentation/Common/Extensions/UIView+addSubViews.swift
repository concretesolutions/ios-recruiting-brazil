//
//  UIView+addSubViews.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UIView {
    func addSubViews(_ subviews: UIView...) {
        subviews.forEach { (subview) in
            self.addSubview(subview)
        }
    }
}
