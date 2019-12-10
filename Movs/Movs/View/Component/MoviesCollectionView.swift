//
//  MoviesCollectionView.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class MoviesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {

    private let itemsPerRow: Int
    private let margin: CGFloat

    required init(itemsPerRow: Int, withMargin margin: CGFloat) {
        self.itemsPerRow = itemsPerRow
        self.margin = margin
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.backgroundColor = .systemBackground
        self.delegate = self
        self.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "moviesCollectionViewCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.bounds.width - (CGFloat(itemsPerRow + 1) * self.margin)) / CGFloat(itemsPerRow)
        return CGSize(width: width, height: width * 1.7)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin * 1.2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }

}
