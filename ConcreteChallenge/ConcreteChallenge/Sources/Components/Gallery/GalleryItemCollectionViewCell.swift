//
//  GalleryItemCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GalleryItemCollectionViewCell: UICollectionViewCell {
    private var containedView: GalleryItemView?

    // MARK: - Functions

    func set(viewModel: GalleryItemViewModel) {
        guard let view = containedView else {
            return setup(viewModel: viewModel)
        }

        view.update(viewModel: viewModel)
    }

    func toggleFavorite() {
        containedView?.toggleFavorite()
    }

    // MARK: - Private functions

    private func create(viewModel: GalleryItemViewModel) -> GalleryItemView {
        return GalleryItemView(viewModel: viewModel)
    }

    private func setup(viewModel: GalleryItemViewModel) {
        let newView = create(viewModel: viewModel)

        containedView = newView

        contentView.addSubviewEqual(equalConstraintFor: newView)
    }
}
