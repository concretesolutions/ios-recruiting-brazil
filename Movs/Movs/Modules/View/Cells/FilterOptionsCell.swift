//
//  FilterOptionsCell.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 21/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

final class FilterOptionsCell: UITableViewCell {

    // MARK: - Reusable Identifier

    static let reuseIdentifier: String = "FilterOptionsCell"

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .systemGray3
        self.selectionStyle = .none
    }

    convenience init(frame: CGRect) {
        self.init(style: .default, reuseIdentifier: FavoriteMovieCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration methods

    func configure(title: String, detail: String) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = detail
    }
}
