//
//  GalleryCollectionView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GalleryCollectionView: UIView, ViewCode {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

        return collectionView
    }()

    // MARK: - Private constants

    private let collectionViewFlowLayout: UICollectionViewFlowLayout

    // MARK: - Initializers

    init(flowLayout: UICollectionViewFlowLayout) {
        collectionViewFlowLayout = flowLayout

        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - ViewCode conforms

    func setupHierarchy() { }

    func setupConstraints() { }

    func setupConfigurations() { }
}
