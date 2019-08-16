//
//  FavoriteMovieTableViewCell.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

class FavoriteMovieTableViewCell: UITableViewCell, Reusable {

    var movie: Movie!

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy var releasedYearLabel: UILabel = {
        let releasedYearLabel = UILabel(frame: .zero)
        releasedYearLabel.translatesAutoresizingMaskIntoConstraints = false
        return releasedYearLabel
    }()

    lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel(frame: .zero)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        return overviewLabel
    }()

    func setup(movie: Movie) {
        self.movie = movie
        setupView()
    }

}

extension FavoriteMovieTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releasedYearLabel)
        contentView.addSubview(overviewLabel)
    }

    func setupConstraints() {

        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.top.equalToSuperview().offset(15)
            make.trailing.equalTo(releasedYearLabel.snp.leading)
            make.width.equalToSuperview().multipliedBy(0.45)
        }

        releasedYearLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(titleLabel.snp.trailing)
        }

        overviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.bottom.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }

    }

    func setupAdditionalConfiguration() {

        contentView.backgroundColor = Design.Colors.gray
        posterImageView.image = self.movie.poster
        titleLabel.text = self.movie.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.numberOfLines = 2
        releasedYearLabel.text = self.movie.releaseYear
        releasedYearLabel.textAlignment = .right
        releasedYearLabel.font = UIFont.systemFont(ofSize: 16.0)
        overviewLabel.text = self.movie.overview
        overviewLabel.font = UIFont.systemFont(ofSize: 14.0)
        overviewLabel.numberOfLines = 3

    }

}
