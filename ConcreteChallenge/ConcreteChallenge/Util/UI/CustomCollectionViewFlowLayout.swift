//
//  CustomCollectionViewFlowLayout.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 30/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    init(itemSize: CGSize, lineSpace: CGFloat = 16, leftSpace: CGFloat = 16) {
        super.init()

        self.scrollDirection = .horizontal

        self.sectionInset = UIEdgeInsets(top: 0.0, left: leftSpace, bottom: 0.0, right: 0.0)
        self.minimumLineSpacing = lineSpace
        self.itemSize = itemSize
    }

    init(columns: Int, padding: CGFloat = 16, aspectRatio: CGFloat = 1) {
        super.init()

        self.sectionInset = UIEdgeInsets(top: padding, left: padding,
                                         bottom: padding, right: padding)
        self.minimumLineSpacing = padding
        self.minimumInteritemSpacing = padding

        let columnCount = CGFloat(columns)
        let collectionViewSize = UIScreen.main.bounds.width - padding * (columnCount + 1)
        self.itemSize = CGSize(width: collectionViewSize / columnCount,
                               height: collectionViewSize / columnCount * aspectRatio)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
