//
//  PopularMoviesCollectionView.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class PopularMoviesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {

    required init(itemsPerRow: Int, withMargin margin: CGFloat) {
        super.init(frame: .zero, collectionViewLayout: Layout(itemsPerRow: itemsPerRow, withMargin: margin))
        self.contentInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        self.backgroundColor = .systemBackground
        self.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "moviesCollectionViewCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private class Layout: UICollectionViewFlowLayout {

    private let itemsPerRow: Int
    private let margin: CGFloat

    override func prepare() {
        guard let collectionView = collectionView else { return }
        let cellWidth = (collectionView.bounds.width - (CGFloat(itemsPerRow + 1) * self.margin)) / CGFloat(itemsPerRow)
        self.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.7)
        self.minimumInteritemSpacing = margin
        self.minimumLineSpacing = margin * 1.2
    }

    required init(itemsPerRow: Int, withMargin margin: CGFloat) {
        self.itemsPerRow = itemsPerRow
        self.margin = margin
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
