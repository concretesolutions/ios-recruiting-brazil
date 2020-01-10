//
//  MovieGridView.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 09/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class MovieGridView: UIView {
    private var collectionView: UICollectionView
    private let marginEdgeInserts: CGFloat = 5
    init() {
        let layout = UICollectionViewFlowLayout.init()
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        subViews()
        style()
        autolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        sv(collectionView)
    }
    
    private func style() {
        setupCollectionView()
    }
    
    private func autolayout() {
        collectionView.fillContainer()
    }
    
    private func setupCollectionView() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: marginEdgeInserts,
                                                     leading: marginEdgeInserts,
                                                     bottom: marginEdgeInserts,
                                                     trailing: marginEdgeInserts)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.25))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }
}
