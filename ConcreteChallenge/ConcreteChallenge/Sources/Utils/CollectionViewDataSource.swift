//
//  CollectionViewDataSource.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class CollectionViewDataSource<M, C>: DataSource<M>, UICollectionViewDataSource where C: UICollectionViewCell {
    typealias CellConfigurator = (M, C) -> Void

    // MARK: - Private constants

    private let cellConfigurator: CellConfigurator

    // MARK: - Initializers

    init(models: [M] = [], cellConfigurator: @escaping CellConfigurator) {
        self.cellConfigurator = cellConfigurator

        super.init(models: models)
    }

    // MARK: - UICollectionViewDataSource conforms

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.className, for: indexPath)

        if let cell = cell as? C {
            let model = get(at: indexPath.row)
            cellConfigurator(model, cell)
        }

        return cell
    }
}
