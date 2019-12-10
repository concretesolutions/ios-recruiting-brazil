//
//  MoviesView.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class MoviesView: UIView {

    let collectionView: MoviesCollectionView = {
        let collectionView = MoviesCollectionView(itemsPerRow: 2, withMargin: 16.0)
        return collectionView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MoviesView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(collectionView)
    }

    func setupContraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {}
    
}
