//
//  PopularMovieCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 15/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class PopularMovieCollectionViewCell: UICollectionViewCell {

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

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(popularityLabel)

        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(movie: Movie) {
        titleLabel.text = movie.title
        popularityLabel.text = "\(movie.popularity)"
        posterImageView.image = movie.posterImage
    }

    private func buildConstraints() {
        posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: bounds.height * 0.75).isActive = true

        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        popularityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        popularityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        popularityLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        popularityLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
