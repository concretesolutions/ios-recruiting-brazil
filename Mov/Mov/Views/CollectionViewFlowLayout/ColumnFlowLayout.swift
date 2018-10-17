//
//  ColumnFlowLayout.swift
//  Mov
//
//  Created by Allan on 09/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        guard let cv = collectionView else { return }
        
        
        
        let availableWidth: CGFloat = cv.bounds.inset(by: cv.layoutMargins).size.width
        let minColumnWidth: CGFloat = 168.0
        let maxColumns: Int = Int(availableWidth / minColumnWidth)
        let cellWidth = ((availableWidth - self.minimumInteritemSpacing * CGFloat(maxColumns)) / CGFloat(maxColumns).rounded(.down))
        
        self.itemSize = CGSize(width: cellWidth, height: 245.0)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: self.minimumInteritemSpacing, bottom: 0.0, right: self.minimumInteritemSpacing)
        
        if #available(iOS 11.0, *) {
            self.sectionInsetReference = .fromSafeArea
        }
    }
    
}
