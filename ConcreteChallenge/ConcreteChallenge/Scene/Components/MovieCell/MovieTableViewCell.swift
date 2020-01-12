//
//  MovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 12/01/20.
//  Copyright © 2020 Marcos Santos. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, Cell {

    lazy var coverImageView = UIImageView()
        .set(\.contentMode, to: .scaleAspectFill)

    lazy var titleLabel = UILabel()
        .set(\.numberOfLines, to: 2)
        .set(\.font, to: UIFont.systemFont(ofSize: 18, weight: .bold))
        .run { label in
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }

    lazy var overviewLabel = UILabel()
        .set(\.numberOfLines, to: 3)

    lazy var yearLabel = UILabel()
        .set(\.textAlignment, to: .right)
        .set(\.textColor, to: .gray)

    var viewModel: MovieCellViewModel? {
        didSet {
            setup()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }

    func setup() {
        setupSubviews()
        setupLayout()

        titleLabel.text = viewModel?.title
        overviewLabel.text = viewModel?.overview
        yearLabel.text = viewModel?.releaseYear
        viewModel?.updateImage = updateImage
        viewModel?.loadImage()

        updateImage()

        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        contentView.layer.borderWidth = 0.5
    }

    func setupSubviews() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(overviewLabel)
    }

    func setupLayout() {
        coverImageView
            .anchor(top: contentView.topAnchor)
            .anchor(leading: contentView.leadingAnchor)
            .anchor(bottom: contentView.bottomAnchor)
            .anchor(aspectRatio: 0.75)

        titleLabel
            .anchor(top: contentView.topAnchor, padding: 16)
            .anchor(leading: coverImageView.trailingAnchor, padding: 8)

        yearLabel
            .anchor(top: contentView.topAnchor, padding: 16)
            .anchor(leading: titleLabel.trailingAnchor, padding: 8)
            .anchor(trailing: contentView.trailingAnchor, padding: 16)

        overviewLabel
            .anchor(top: titleLabel.bottomAnchor, padding: 8)
            .anchor(leading: coverImageView.trailingAnchor, padding: 8)
            .anchor(trailing: contentView.trailingAnchor, padding: 16)
    }

    func updateImage() {
        coverImageView.image = viewModel?.image
    }
}
