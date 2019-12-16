//
//  MovieDetailsView.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 16/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {

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

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(posterImageView)
        addSubview(titleLabel)

        buildConstraints()
    }

    func setup(movie: Movie) {
        titleLabel.text = movie.title
        posterImageView.image = movie.posterImage
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
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor)
        ])
    }
}
