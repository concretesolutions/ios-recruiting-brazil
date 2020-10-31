//
//  InfoListItemTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class InfoListItemTableViewCell: UITableViewCell {
    private var containedView: InfoListItemView?

    // MARK: - Functions

    func set(viewModel: InfoListItemViewModel) {
        guard let view = containedView else {
            return setup(viewModel: viewModel)
        }

        view.update(viewModel: viewModel)
    }

    // MARK: - Private functions

    private func create(viewModel: InfoListItemViewModel) -> InfoListItemView {
        return InfoListItemView(viewModel: viewModel)
    }

    private func setup(viewModel: InfoListItemViewModel) {
        let newView = create(viewModel: viewModel)

        containedView = newView

        contentView.addSubviewEqual(equalConstraintFor: newView)
    }
}
