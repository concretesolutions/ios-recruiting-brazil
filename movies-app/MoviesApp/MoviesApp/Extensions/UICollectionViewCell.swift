//
//  UICollectionViewCell.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    @nonobjc static var reusableIdentifier: String {
        return String(describing: self)
    }
}
