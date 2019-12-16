//
//  FavoriteMovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 16/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 17, weight: .medium)

        return label
    }()

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 15, weight: .regular)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(overviewLabel)

        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(favorite: FavoriteMovie) {
        titleLabel.text = favorite.title
        overviewLabel.text = excerpt(from: favorite.overview!)

        if let posterImageData = favorite.posterImage {
            posterImageView.image = UIImage(data: posterImageData)
        }
    }

    func excerpt(from overview: String) -> String {
        guard overview.count > 100 else { return overview }
        return String(overview.prefix(100)) + "..."
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 140),

            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),

            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

}
