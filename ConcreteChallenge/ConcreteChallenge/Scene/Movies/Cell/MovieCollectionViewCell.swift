//
//  MovieCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, Cell {

    lazy var coverImageView = UIImageView()
        .set(\.contentMode, to: .scaleAspectFill)

    lazy var titleLabel = UILabel()
        .set(\.numberOfLines, to: 2)
        .set(\.textColor, to: .white)
        .set(\.font, to: UIFont.systemFont(ofSize: 20, weight: .bold))

    lazy var favoriteButton = UIButton()
        .set(\.tintColor, to: .white)

    var viewModel: MovieCellViewModel? {
        didSet {
            favoriteButton.removeTarget(oldValue, action: #selector(oldValue?.favorite), for: .touchUpInside)
            setup()
        }
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup() {
        setupSubviews()
        setupLayout()

        titleLabel.text = viewModel?.title
        viewModel?.updateImage = updateImage
        viewModel?.updateFavoriteButton = updateFavoriteButton
        viewModel?.loadImage()

        updateImage()
        updateFavoriteButton()

        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8

        favoriteButton.addTarget(viewModel, action: #selector(viewModel?.favorite), for: .touchUpInside)
    }

    func setupSubviews() {
        contentView.addSubview(coverImageView)

        contentView.layer.addSublayer(Gradient.main(contentView.frame.size.width, 64))
        contentView.layer.addSublayer(Gradient.main(contentView.frame.size.width, 64,
                                                   isBottomUp: true,
                                                   elementHeight: contentView.frame.size.height))

        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
    }

    func setupLayout() {
        coverImageView.fillToSuperview()

        titleLabel
            .anchor(leading: contentView.leadingAnchor, padding: 8)
            .anchor(trailing: contentView.trailingAnchor, padding: 8)
            .anchor(bottom: contentView.bottomAnchor, padding: 16)

        favoriteButton
            .anchor(top: contentView.topAnchor, padding: 16)
            .anchor(trailing: contentView.trailingAnchor, padding: 8)
    }

    func updateImage() {
        coverImageView.image = viewModel?.image
    }

    func updateFavoriteButton() {
        favoriteButton.setImage(viewModel?.favoriteIcon, for: .normal)
    }
}
