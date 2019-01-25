//
//  FavoriteMovieCell.swift
//  Movs
//
//  Created by Filipe Jordão on 25/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import SnapKit
import Nuke

class FavoriteMovieCell: UITableViewCell {
    static let identifier = "FavoriteMovieCell"
    let horizontalMargin = 10
    let toTopMargin = 20
    var viewModel: FavoriteMovieViewModel?

    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    let yearLabel = UILabel()
    let overviewLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with viewModel: FavoriteMovieViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        yearLabel.text = viewModel.year
        overviewLabel.text = viewModel.overview

        guard let image = viewModel.image else { return }
        Nuke.loadImage(with: image, into: coverImageView)
    }
}

extension FavoriteMovieCell: ViewConfiguration {
    func setupViews() {
        overviewLabel.numberOfLines = 0
    }

    func setupHierarchy() {
        [coverImageView, titleLabel, yearLabel, overviewLabel].forEach(contentView.addSubview)
    }

    func setupConstraints() {
        coverImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(coverImageView.snp.height).dividedBy(1.5)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImageView.snp.right).offset(horizontalMargin)
            make.top.equalTo(contentView).offset(toTopMargin)

        }

        yearLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.top.bottom.equalTo(titleLabel)
            make.right.equalTo(contentView).inset(horizontalMargin)
        }

        overviewLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImageView.snp.right).offset(horizontalMargin)
            make.top.equalTo(titleLabel.snp.bottom).offset(toTopMargin)
            make.bottom.right.equalTo(contentView)
        }
    }
}
