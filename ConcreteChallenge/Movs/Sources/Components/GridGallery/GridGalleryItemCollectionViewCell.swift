//
//  GridGalleryItemCollectionViewCell.swift
//  Movs
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GridGalleryItemCollectionViewCell: UICollectionViewCell {
    private var containedView: GridGalleryItemView?

    // MARK: - Functions

    func set(viewModel: GridGalleryItemViewModel) {
        guard let view = containedView else {
            return setup(viewModel: viewModel)
        }

        view.update(viewModel: viewModel)
    }

    // MARK: - Private functions

    private func create(viewModel: GridGalleryItemViewModel) -> GridGalleryItemView {
        return GridGalleryItemView(viewModel: viewModel)
    }

    private func setup(viewModel: GridGalleryItemViewModel) {
        let newView = create(viewModel: viewModel)

        containedView = newView

        contentView.addSubviewEqual(equalConstraintFor: newView)
    }
}
