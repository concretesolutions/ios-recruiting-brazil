//
//  GridGalleryItemView.swift
//  Movs
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit
import Kingfisher

final class GridGalleryItemView: UIView {
    private lazy var movieImageView = UIImageView()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .appYellowLight

        return label
    }()

    private lazy var favoriteImageView = UIImageView()

    private lazy var titleFavoriteImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBlackLight

        return view
    }()

    // MARK: - Private constants

    private var viewModel: GridGalleryItemViewModel

    private var imageURL: String = .empty {
        didSet {
            movieImageView.kf.setImage(with: URL(string: viewModel.imageURL))
        }
    }

    private var titleText: String = .empty {
        didSet {
            title.text = titleText
        }
    }

    private var isFavorite: Bool = false {
        didSet {
            let imageAssets: UIImage.Assets = isFavorite ? .favoriteFullIcon : .favoriteGrayIcon
            let image = UIImage(assets: imageAssets)?.withInsets(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
            favoriteImageView.image = image
        }
    }

    // MARK: - Initializers

    public init(viewModel: GridGalleryItemViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private functions

    private func setupLayout() {
        addSubview(movieImageView, constraints: [
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        addSubview(titleFavoriteImageView, constraints: [
            titleFavoriteImageView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            titleFavoriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleFavoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleFavoriteImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        titleFavoriteImageView.addSubview(title, constraints: [
            title.topAnchor.constraint(equalTo: titleFavoriteImageView.topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: titleFavoriteImageView.leadingAnchor, constant: 12),
            title.bottomAnchor.constraint(equalTo: titleFavoriteImageView.bottomAnchor, constant: -12)
        ])

        titleFavoriteImageView.addSubview(favoriteImageView, constraints: [
            favoriteImageView.topAnchor.constraint(equalTo: titleFavoriteImageView.topAnchor),
            favoriteImageView.leadingAnchor.constraint(greaterThanOrEqualTo: title.trailingAnchor, constant: 4),
            favoriteImageView.trailingAnchor.constraint(equalTo: titleFavoriteImageView.trailingAnchor),
            favoriteImageView.bottomAnchor.constraint(equalTo: titleFavoriteImageView.bottomAnchor)
        ])

        favoriteImageView.setContentCompressionResistancePriority(.required, for: .horizontal)

        imageURL = viewModel.imageURL
        titleText = viewModel.title
        isFavorite = viewModel.isFavorite

        backgroundColor = .clear
    }

    // MARK: - Functions

    func update(viewModel new: GridGalleryItemViewModel) {
        viewModel = new

        imageURL = viewModel.imageURL
        titleText = viewModel.title
        isFavorite = viewModel.isFavorite
    }
}
