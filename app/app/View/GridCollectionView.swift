//
//  GridCollectionView.swift
//  app
//
//  Created by rfl3 on 20/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class GridCollectionView: UICollectionView {

    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension GridCollectionView: CodeView {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }

}
