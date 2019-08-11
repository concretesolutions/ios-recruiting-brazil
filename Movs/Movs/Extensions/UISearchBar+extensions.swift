//
//  UISearchBar+extensions.swift
//  Movs
//
//  Created by Marcos Lacerda on 10/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

extension UISearchBar {
  
  func centeredPlaceHolder() {
    guard let searchField = self.value(forKey: "_searchField") as? UITextField, let searchIcon = searchField.leftView as? UIImageView else { return }

    // Get sizes
    let searchBarWidth = self.frame.width
    let placeholderIconWidth = searchIcon.frame.width
    let placeholderSize = searchField.attributedPlaceholder?.size().width ?? 0.0
    let offsetIconToPlaceholder: CGFloat = 8
    let placeholderWithIcon = placeholderIconWidth + offsetIconToPlaceholder
    let x = ((searchBarWidth / 2) - (placeholderSize / 2) - placeholderWithIcon)
    
    let offset: UIOffset = UIOffset(horizontal: x, vertical: 0)
    
    self.setPositionAdjustment(offset, for: .search)
  }
  
  func clearOffset() {
    self.setPositionAdjustment(.zero, for: .search)
  }
  
}
