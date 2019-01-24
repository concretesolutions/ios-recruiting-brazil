//
//  PopularMovieCell.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import SnapKit
import Nuke
import UIKit

class PopularMovieCell: UICollectionViewCell {
    static let reuseId = "PopularMovieCell"
    let containerHeight = 40

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let favoriteImage = UIImageView()
    let containerView = UIView()

    var viewModel: MovieViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with viewModel: MovieViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title
        guard let url = viewModel.image else { return }
        Nuke.loadImage(with: url, into: imageView)
    }
}

extension PopularMovieCell: ViewConfiguration {
    func setupViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        favoriteImage.image = #imageLiteral(resourceName: "favorite_full_icon")

        containerView.backgroundColor = .movsBlue
    }

    func setupHierarchy() {
        [imageView, containerView].forEach(contentView.addSubview)
        [titleLabel, favoriteImage].forEach(containerView.addSubview)
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(containerHeight)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(containerView)
        }

        favoriteImage.snp.makeConstraints { make in
            make.bottom.right.top.equalTo(containerView).inset(10)
            make.width.equalTo(favoriteImage.snp.height)
        }
    }
}
