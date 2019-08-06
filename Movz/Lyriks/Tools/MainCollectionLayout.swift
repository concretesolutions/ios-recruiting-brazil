//
//  MainCollectionLayout.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 29/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit




class MainCollectionLayout: UICollectionViewFlowLayout {
   var sideItemScale: CGFloat = 0.8
   var sideItemAlpha: CGFloat = 1.0
   var sideItemShift: CGFloat = 0.0
   var spacing:CGFloat = 10
    override func prepare() {
        super.prepare()
        //make the scroll decelerate faster
        guard let collectionView = self.collectionView else { return }
        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
        //size on screen for collection
        let collectionSize = collectionView.bounds.size
        //make so item stay on the middle of collection with X inset
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: 0, left: xInset, bottom: 0, right: 0)
        
        //calculate line spacing with scale
        let side = self.itemSize.width
        let scaledItemOffset =  (side - side*self.sideItemScale) / 2
        self.minimumLineSpacing = spacing - scaledItemOffset
        
      
        
        
    }
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }
    private func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let collectionCenter = collectionView.frame.size.width/2
        let offset = collectionView.contentOffset.x
        let normalizedCenter = attributes.center.x  - offset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        //make transformation on cells
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        let shift = (1 - ratio) * self.sideItemShift
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)
        
        attributes.center.y = attributes.center.y + shift

        
        return attributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    //used to "pin-up"near cell to the center
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView , !collectionView.isPagingEnabled,
            let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds)
            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }

        let midSide = (collectionView.bounds.size.width) / 2
        let proposedContentOffsetCenterOrigin = (proposedContentOffset.x) + midSide
        
        var targetContentOffset: CGPoint
        let closest = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
     
        return targetContentOffset
    }



}



