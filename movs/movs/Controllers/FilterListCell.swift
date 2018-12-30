//
//  FilterListCell.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 27/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit

final class FilterListCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var selectedFilter: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
}

// MARK: - Public
extension FilterListCell {
    func setup(title: String, filter: String) {
		titleLabel.text = title
        selectedFilter.text = filter
    }
}
