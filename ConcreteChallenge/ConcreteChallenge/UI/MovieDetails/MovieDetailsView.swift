//
//  MovieDetailsView.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 16/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {

    var isFavorited: Bool = false {
        didSet {
            let imageName = isFavorited ? "favorite_full_icon" : "favorite_gray_icon"
            favoriteButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 17, weight: .medium)

        return label
    }()

    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)

        return button
    }()

    let genreNamesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 15, weight: .regular)

        return label
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 17, weight: .regular)

        return label
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }

        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(genreNamesLabel)
        addSubview(favoriteButton)
        addSubview(overviewLabel)

        buildConstraints()
        aditionalConfiguration()
    }

    func setup(viewModel: MovieDetailsViewModel) {
        titleLabel.text = viewModel.title
        posterImageView.image = viewModel.posterImage
        isFavorited = viewModel.isFavorited
        favoriteButtonAction = {
            viewModel.favoriteButtonHandler { self.isFavorited = $0 }
        }
        genreNamesLabel.text = viewModel.genreNames.joined(separator: " | ")
        overviewLabel.text = viewModel.overview
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),

            genreNamesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            genreNamesLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            genreNamesLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),

            favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),

            overviewLabel.topAnchor.constraint(equalTo: genreNamesLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor)
        ])
    }

    private func aditionalConfiguration() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
    }

    var favoriteButtonAction: (() -> Void)?
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        favoriteButtonAction?()
    }
}
