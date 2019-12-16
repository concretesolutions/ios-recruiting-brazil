//
//  PopularMovieCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 15/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class PopularMovieCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    private var movieID = 0

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 15, weight: .medium)

        return label
    }()

    let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .darkGray

        return label
    }()

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorite_gray_icon")!, for: .normal)

        return button
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        addSubview(favoriteButton)
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(popularityLabel)

        buildConstraints()
        aditionalConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(movie: Movie, favoriteAction: @escaping () -> Void) {
        titleLabel.text = movie.title
        popularityLabel.text = "\(movie.popularity)"
        posterImageView.image = movie.posterImage
        self.favoriteButtonAction = favoriteAction
    }

    private func buildConstraints() {
        posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: bounds.height * 0.75).isActive = true

        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10).isActive = true

        popularityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        popularityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        popularityLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        popularityLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

        favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func aditionalConfiguration() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
    }

    private var favoriteButtonAction: (() -> Void)?
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        favoriteButtonAction?()
    }
}
