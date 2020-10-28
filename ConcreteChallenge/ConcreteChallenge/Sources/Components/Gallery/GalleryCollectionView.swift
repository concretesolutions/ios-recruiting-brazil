//
//  GalleryCollectionView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GalleryCollectionView: UIView {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = dataSource
        collectionView.register(GalleryItemCollectionViewCell.self)

        return collectionView
    }()

    // MARK: - Private constants

    private let collectionViewFlowLayout: UICollectionViewFlowLayout

    private let dataSource: UICollectionViewDataSource & DataSource = {
        CollectionViewDataSource<GalleryItemViewModel, GalleryItemCollectionViewCell>() { viewModel, cell in
            cell.set(viewModel: viewModel)
        }
    }()

    // MARK: - Initializers

    convenience init(itemSize: CGSize, items: [GalleryItemViewModel]) {
        self.init(itemSize: itemSize, items: items, flowLayout: GalleryCollectionViewFactory.makeFlowLayout(itemSize: itemSize))
    }

    init(itemSize: CGSize, items: [GalleryItemViewModel], flowLayout: UICollectionViewFlowLayout) {
        collectionViewFlowLayout = flowLayout

        super.init(frame: .zero)

        setupDataSource(items: items)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Public functions

    func setupDataSource(items: [GalleryItemViewModel]) {
        dataSource.set(models: items)
        collectionView.reloadData()
    }

    // MARK: - Private functions

    private func setupLayout() {
        addSubviewEqual(equalConstraintFor: collectionView)

        collectionView.backgroundColor = .clear
        backgroundColor = .clear
    }
}
