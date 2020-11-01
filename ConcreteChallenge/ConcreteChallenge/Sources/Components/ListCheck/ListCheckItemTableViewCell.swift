//
//  ListCheckItemTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class ListCheckItemTableViewCell: UITableViewCell {
    private var containedView: ListCheckItemView?

    // MARK: - Functions

    func set(viewModel: ListCheckItemViewModel) {
        guard let view = containedView else {
            return setup(viewModel: viewModel)
        }

        view.update(viewModel: viewModel)
    }

    // MARK: - Override functions

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0))
    }

    // MARK: - Private functions

    private func create(viewModel: ListCheckItemViewModel) -> ListCheckItemView {
        return ListCheckItemView(viewModel: viewModel)
    }

    private func setup(viewModel: ListCheckItemViewModel) {
        let newView = create(viewModel: viewModel)

        containedView = newView

        contentView.addSubviewEqual(equalConstraintFor: newView)
    }
}
