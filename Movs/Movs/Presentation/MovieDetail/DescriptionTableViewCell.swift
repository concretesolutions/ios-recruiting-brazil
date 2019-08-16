//
//  DescriptionTableViewCell.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

public protocol FavoriteMovieDelegate: AnyObject {
    func changeFavorite(to status: Bool)
}

final class DescriptionTableViewCell: UITableViewCell, Reusable {

    var isFavorite: Bool = false
    //swiftlint:disable weak_delegate
    var favoriteDelegate: FavoriteMovieDelegate?

    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func setup(movieDetail: String) {
        label.text = movieDetail
        favoriteButton.isHidden = true
        setupView()
    }

    func setup(movieDetail: String, isFavorite: Bool, delegate: FavoriteMovieDelegate) {
        self.isFavorite = isFavorite
        self.favoriteDelegate = delegate
        label.text = movieDetail  + movieDetail
        favoriteButton.isHidden = false
        setupView()
    }

    @objc
    func favoriteButtonTapped() {
        isFavorite.toggle()
        if self.isFavorite {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
        self.favoriteDelegate?.changeFavorite(to: self.isFavorite)
    }
}

extension DescriptionTableViewCell: CodeView {

    func buildViewHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(favoriteButton)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(50)
        }

        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

    }

    func setupAdditionalConfiguration() {
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0)

        favoriteButton.contentMode = .scaleAspectFit
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }
}
