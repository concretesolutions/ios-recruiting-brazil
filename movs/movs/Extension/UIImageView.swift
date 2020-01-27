//
//  UIImageView.swift
//  movs
//
//  Created by Isaac Douglas on 27/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

extension UIImageView {
    func setColor(_ color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
