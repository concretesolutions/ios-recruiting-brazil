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
    let toImageMargin = 15
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
    func setupHierarchy() {
        [coverImageView, titleLabel, yearLabel, overviewLabel].forEach(contentView.addSubview)
    }

    func setupConstraints() {
        coverImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(coverImageView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImageView.snp.right).offset(toImageMargin)
            make.top.equalTo(contentView)
            
        }

        yearLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.top.equalTo(contentView).offset(toTopMargin)
            make.right.equalTo(contentView)
        }

        overviewLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImageView.snp.right).offset(toImageMargin)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.right.equalTo(contentView)
        }
    }
}
