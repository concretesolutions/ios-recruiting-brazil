//
//  GalleryItemView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GalleryItemView: UIView {
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red

        return imageView
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .appYellowLight
        label.text = viewModel.movie.title

        return label
    }()

    private lazy var favoriteImageView: UIImageView = {
        let image = UIImage(assets: .favoriteGrayIcon)?.withInsets(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        let imageView = UIImageView(image: image)

        return imageView
    }()

    private lazy var titleFavoriteImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBlackLight

        return view
    }()

    // MARK: - Private constants

    private var viewModel: GalleryItemViewModel

    // MARK: - Initializers

    public init(viewModel: GalleryItemViewModel) {
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
            title.bottomAnchor.constraint(equalTo: titleFavoriteImageView.bottomAnchor, constant: -12),
            title.centerXAnchor.constraint(equalTo: titleFavoriteImageView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: titleFavoriteImageView.centerYAnchor)
        ])

        titleFavoriteImageView.addSubview(favoriteImageView, constraints: [
            favoriteImageView.topAnchor.constraint(equalTo: titleFavoriteImageView.topAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: titleFavoriteImageView.trailingAnchor),
            favoriteImageView.bottomAnchor.constraint(equalTo: titleFavoriteImageView.bottomAnchor),
            favoriteImageView.centerYAnchor.constraint(equalTo: titleFavoriteImageView.centerYAnchor)
        ])
    }
}
