//
//  MoviesCollectionViewCell.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MoviesCollectionViewCell: UICollectionViewCell, ConfigView {

    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let movieName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .yellow
        label.backgroundColor = .darkGray
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViewHierarchy() {
        self.addSubview(movieImage)
        self.addSubview(movieName)
        self.addSubview(favoriteButton)

    }
    func addConstraints() {
        //movieImage constraints
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        //movieName constraints
        NSLayoutConstraint.activate([
            movieName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])

        //favoriteButton constraint
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            favoriteButton.centerYAnchor.constraint(equalTo: movieName.centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalTo: movieImage.heightAnchor, multiplier: 0.3),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor, multiplier: 0.5)
        ])

    }
}

extension  MoviesCollectionViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
