//
//  UICollectionView+insertItems.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UICollectionView {
    func insertItemsInRange(_ range: Range<Int>) {
        self.insertItems(at: range.map { (currentRowIndex) -> IndexPath in
            return .init(row: currentRowIndex, section: 0)
        })
    }
}
