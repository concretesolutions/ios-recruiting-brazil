//
//  MoviePosterTableViewCell.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

final class MoviePosterTableViewCell: UITableViewCell, Reusable {

    lazy var poster: UIImageView = {
        let poster = UIImageView(frame: .zero)
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()

    func setup(posterImage: UIImage) {
        self.poster.image = posterImage
        setupView()
    }

}

extension MoviePosterTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(poster)
    }

    func setupConstraints() {

        poster.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }

    func setupAdditionalConfiguration() {
        poster.contentMode = .scaleAspectFit
    }
}
