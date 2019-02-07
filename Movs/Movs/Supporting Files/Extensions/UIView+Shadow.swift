//
//  UIView+Shadow.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

extension UIView {
  func addShadow() {
    layer.shadowColor = ColorPalette.black.withAlphaComponent(0.6).cgColor
    layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    layer.shadowOpacity = 0.8
    layer.shadowRadius = 4
  }
}
