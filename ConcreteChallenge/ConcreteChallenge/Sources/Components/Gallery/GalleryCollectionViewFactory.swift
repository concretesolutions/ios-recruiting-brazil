//
//  GalleryCollectionViewFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 28/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum GalleryCollectionViewFactory {
    static func makeCollectionView(itemSize: CGSize, items: [GalleryItemViewModel]) -> GalleryCollectionView {
        let collectionView = GalleryCollectionView(itemSize: itemSize, items: items)

        return collectionView
    }

    static func makeFlowLayout(itemSize: CGSize) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let verticalMargin = CGFloat(Constants.GalleryCollectionView.verticalMargin)
        let horizontalMargin = CGFloat(Constants.GalleryCollectionView.horizontalMargin)
        let minimumLineSpacing = CGFloat(Constants.GalleryCollectionView.minimumLineSpacing)

        layout.itemSize = itemSize
        layout.sectionInset = UIEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin)
        layout.minimumLineSpacing = minimumLineSpacing

        return layout
    }
}
