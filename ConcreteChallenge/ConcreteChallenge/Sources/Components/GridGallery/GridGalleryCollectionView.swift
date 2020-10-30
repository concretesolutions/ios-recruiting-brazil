//
//  GridGalleryCollectionView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GridGalleryCollectionView: UIView, UICollectionViewDelegate {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = dataSource
        collectionView.register(GridGalleryItemCollectionViewCell.self)

        return collectionView
    }()

    // MARK: - Constants

    private var onItemPress: ((_ index: Int) -> Void)?

    // MARK: - Private constants

    private let collectionViewFlowLayout: UICollectionViewFlowLayout

    private let dataSource: UICollectionViewDataSource & DataSource = {
        CollectionViewDataSource<GridGalleryItemViewModel, GridGalleryItemCollectionViewCell>() { viewModel, cell in
            cell.set(viewModel: viewModel)
        }
    }()

    // MARK: - Initializers

    convenience init(itemSize: CGSize, items: [GridGalleryItemViewModel]) {
        self.init(itemSize: itemSize, items: items, flowLayout: GridGalleryCollectionViewFactory.makeFlowLayout(itemSize: itemSize))
    }

    init(itemSize: CGSize, items: [GridGalleryItemViewModel], flowLayout: UICollectionViewFlowLayout) {
        collectionViewFlowLayout = flowLayout

        super.init(frame: .zero)

        setupDataSource(items: items)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Functions

    func setupDataSource(items: [GridGalleryItemViewModel]) {
        dataSource.set(models: items)
        collectionView.reloadData()
    }

    func bind(onItemPress handler: @escaping (_ index: Int) -> Void) {
        collectionView.delegate = self
        onItemPress = handler
    }

    // MARK: - UICollectionViewDelegate conforms

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onItemPress?(indexPath.row)
    }

    // MARK: - Private functions

    private func setupLayout() {
        addSubviewEqual(equalConstraintFor: collectionView)

        collectionView.backgroundColor = .clear
        backgroundColor = .clear
    }
}
