//
//  FilterCell.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 22/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    // MARK: - Reusable Identifier

    static let reuseIdentifier: String = "FilterCell"

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemGray3
    }

    convenience init(frame: CGRect) {
        self.init(style: .default, reuseIdentifier: FilterCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration methods

    func configure(title: String) {
        self.textLabel?.text = title
    }
}
