//
//  HorizontalInfoListViewCell.swift
//  Movs
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class HorizontalInfoListViewCell: UITableViewCell {
    private var containedView: HorizontalInfoListItemView?

    // MARK: - Functions

    func set(viewModel: HorizontalInfoListViewModel) {
        guard let view = containedView else {
            return setup(viewModel: viewModel)
        }

        view.update(viewModel: viewModel)
    }

    // MARK: - Override functions

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0))
    }

    // MARK: - Private functions

    private func create(viewModel: HorizontalInfoListViewModel) -> HorizontalInfoListItemView {
        return HorizontalInfoListItemView(viewModel: viewModel)
    }

    private func setup(viewModel: HorizontalInfoListViewModel) {
        let newView = create(viewModel: viewModel)

        containedView = newView

        contentView.addSubviewEqual(equalConstraintFor: newView)
    }
}
