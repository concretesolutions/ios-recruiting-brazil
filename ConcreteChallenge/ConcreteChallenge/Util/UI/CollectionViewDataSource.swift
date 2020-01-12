//
//  CollectionViewDataSource.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 23/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class CollectionViewDataSource<C: Cell & UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    var viewModels: [C.ViewModelType]

    init(viewModels: [C.ViewModelType]) {
        self.viewModels = viewModels
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(C.self, for: indexPath)
            .set(\.viewModel, to: viewModels[indexPath.item])
    }
}
