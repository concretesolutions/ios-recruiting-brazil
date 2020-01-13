//
//  UIView+Extensio.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 12/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func border(withRadius radius: CGFloat, andColor: UIColor = .clear) {
        layer.cornerRadius = radius
        layer.borderColor = andColor.cgColor
        layer.borderWidth = 2.0
        self.clipsToBounds = true
    }
}
