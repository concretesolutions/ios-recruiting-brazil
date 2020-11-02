//
//  GridGalleryCollectionViewFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 28/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum GridGalleryCollectionViewFactory {
    static func make(itemSize: CGSize, items: [GridGalleryItemViewModel]) -> GridGalleryCollectionView {
        let collectionView = GridGalleryCollectionView(itemSize: itemSize, items: items)

        return collectionView
    }

    static func makeFlowLayout(itemSize: CGSize) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let verticalMargin = CGFloat(Constants.GridGalleryCollectionView.verticalMargin)
        let horizontalMargin = CGFloat(Constants.GridGalleryCollectionView.horizontalMargin)
        let minimumLineSpacing = CGFloat(Constants.GridGalleryCollectionView.minimumLineSpacing)

        layout.itemSize = itemSize
        layout.sectionInset = UIEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin)
        layout.minimumLineSpacing = minimumLineSpacing

        return layout
    }
}
