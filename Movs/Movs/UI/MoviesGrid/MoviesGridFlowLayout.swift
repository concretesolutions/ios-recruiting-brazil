//
//  MoviesGridFlowLayout.swift
//  Movs
//
//  Created by Gabriel Reynoso on 25/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MoviesGridFlowLayout: UICollectionViewFlowLayout {
    
    private static let numberOfItemsPerLine:Int = 2
    private static let lineSpacing:CGFloat = 20.0
    private static let itemSpacing:CGFloat = 15.0
    
    override init() {
        super.init()
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.minimumLineSpacing = MoviesGridFlowLayout.lineSpacing
        self.minimumInteritemSpacing = MoviesGridFlowLayout.itemSpacing
        self.sectionInset = UIEdgeInsets(top: MoviesGridFlowLayout.lineSpacing,
                                         left: MoviesGridFlowLayout.itemSpacing,
                                         bottom: MoviesGridFlowLayout.lineSpacing,
                                         right: MoviesGridFlowLayout.itemSpacing)
    }
    
    static func calculateItemSize(for collectionSize: CGSize) -> CGSize {
        let horizontalWhiteSpace = CGFloat(MoviesGridFlowLayout.numberOfItemsPerLine + 1) * MoviesGridFlowLayout.itemSpacing
        let horizontalCellSpace = collectionSize.width - horizontalWhiteSpace
        let itemWitdh = horizontalCellSpace/CGFloat(MoviesGridFlowLayout.numberOfItemsPerLine)
        return CGSize(width: itemWitdh, height: 200.0)
    }
}
