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
            let imageName = isFavorited ? "favorite_full_icon" : "favorite_empty_icon"
            saveFavoriteButton.setImage(UIImage(named: imageName), for: .normal)
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

    let saveFavoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)

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

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(genreNamesLabel)
        addSubview(saveFavoriteButton)

        buildConstraints()
        aditionalConfiguration()
    }

    func setup(movie: Movie, favoriteAction: @escaping () -> Void) {
        titleLabel.text = movie.title
        posterImageView.image = movie.posterImage
        self.saveFavoriteAction = favoriteAction
    }

    func updateGenres(with genres: [Genre]) {
        let names = genres.map({ $0.name })
        genreNamesLabel.text = names.joined(separator: " | ")
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
            titleLabel.trailingAnchor.constraint(equalTo: saveFavoriteButton.leadingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),

            genreNamesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            genreNamesLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            genreNamesLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),

            saveFavoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            saveFavoriteButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            saveFavoriteButton.heightAnchor.constraint(equalToConstant: 50),
            saveFavoriteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func aditionalConfiguration() {
        saveFavoriteButton.addTarget(self, action: #selector(saveFavoriteButtonTapped(_:)), for: .touchUpInside)
    }

    var saveFavoriteAction: (() -> Void)?
    @objc func saveFavoriteButtonTapped(_ sender: UIButton) {
        saveFavoriteAction?()
    }
}
