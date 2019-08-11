//
//  UIView+extensions.swift
//  Movs
//
//  Created by Marcos Lacerda on 10/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

extension UIView {
  
  func roundedCorners(_ radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
  
}
