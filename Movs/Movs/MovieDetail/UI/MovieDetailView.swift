//
//  MovieDetailView.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let genresLabel = UILabel()
    let overviewLabel = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailView: ViewConfiguration {
    func setupViews() {
        overviewLabel.isEditable = false
        [imageView, titleLabel, genresLabel, overviewLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func setupHierarchy() {
        [imageView, titleLabel, genresLabel, overviewLabel].forEach(addSubview)
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.left.top.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.45)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.05)
        }

        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.05)
        }

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
}
