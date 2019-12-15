//
//  CollectionViewFlowLayout.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

public protocol CollectionViewFlowLayoutDelegate: class {
    func numberOfColumns() -> Int
    func height(at indexPath: IndexPath) -> CGFloat
}

public class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var cache: [IndexPath : UICollectionViewLayoutAttributes] = [:]
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    public weak var flowDelegate: CollectionViewFlowLayoutDelegate?

    public override var collectionViewContentSize: CGSize {
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }

    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
        if cache.isEmpty {
            self.prepare()
        }
        for (_, layoutAttributes) in self.cache {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        return layoutAttributesArray
    }

    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath]
    }

    public override func prepare() {
        super.prepare()
        self.cache.removeAll()
        
        guard let collectionView = self.collectionView else {
            return
        }
        let numberOfColumns = self.flowDelegate?.numberOfColumns() ?? 1
        let cellPadding: CGFloat = 8
        self.contentHeight = 0
        let columnWidth = UIScreen.main.bounds.width / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        if collectionView.numberOfSections > 0 {
            for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let photoHeight = self.flowDelegate?.height(at: indexPath) ?? 1
                let height = cellPadding * 2 + photoHeight
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                self.cache[indexPath] = attributes
                self.contentHeight = max(self.contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
        }
    }
}

