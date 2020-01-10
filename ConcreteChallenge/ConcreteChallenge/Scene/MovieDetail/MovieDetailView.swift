//
//  MovieDetailView.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class MovieDetailView: UIView, ViewCode {

    lazy var loadingView = LoadingView()

    lazy var scrollView = UIScrollView()
        .set(\.contentInsetAdjustmentBehavior, to: .never)
        .set(\.delegate, to: self)

    lazy var contentView = UIView()

    lazy var coverImageView = UIImageView()
        .set(\.contentMode, to: .scaleAspectFill)
        .set(\.clipsToBounds, to: true)

    lazy var titleLabel = UILabel()
        .set(\.numberOfLines, to: 0)
        .set(\.font, to: UIFont.systemFont(ofSize: 20, weight: .bold))

    lazy var overviewLabel = UILabel()
        .set(\.numberOfLines, to: 0)

    lazy var genresLabel = UILabel()
        .set(\.numberOfLines, to: 0)
        .set(\.textColor, to: .gray)
        .run { label in
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }

    lazy var yearLabel = UILabel()
        .set(\.textColor, to: .gray)
        .set(\.textAlignment, to: .right)

    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        setupSubviews()
        setupLayout()

        self.backgroundColor = .white
    }

    func setupSubviews() {
        addSubview(loadingView)
        addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(overviewLabel)
    }

    func setupLayout() {
        loadingView.fillToSuperview()

        scrollView
            .anchor(top: self.topAnchor)
            .anchor(leading: self.leadingAnchor)
            .anchor(trailing: self.trailingAnchor)
            .anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor)

        contentView
            .anchor(width: self.widthAnchor)
            .fillToSuperview(safeArea: false)

        coverImageView
            .anchor(top: contentView.topAnchor)
            .anchor(centerX: contentView.centerXAnchor)
            .anchor(width: contentView.widthAnchor)
            .anchor(aspectRatio: 0.75)

        titleLabel
            .anchor(top: coverImageView.bottomAnchor, padding: 16)
            .anchor(leading: contentView.leadingAnchor, padding: 16)
            .anchor(trailing: contentView.trailingAnchor, padding: 16)

        genresLabel
            .anchor(top: titleLabel.bottomAnchor, padding: 8)
            .anchor(leading: contentView.leadingAnchor, padding: 16)

        yearLabel
            .anchor(top: titleLabel.bottomAnchor, padding: 8)
            .anchor(leading: genresLabel.trailingAnchor, padding: 16)
            .anchor(trailing: contentView.trailingAnchor, padding: 16)

        overviewLabel
            .anchor(top: genresLabel.bottomAnchor, padding: 16)
            .anchor(leading: contentView.leadingAnchor, padding: 16)
            .anchor(trailing: contentView.trailingAnchor, padding: 16)
            .anchor(bottom: contentView.bottomAnchor, padding: 16)
    }

    func setLoadingLayout() {
        loadingView.isHidden = false
        loadingView.start()

        contentView.isHidden = true
    }
}

extension MovieDetailView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset

        if offset.y < 0.0 {
            let scaleFactor = 1 + (-1 * offset.y / (coverImageView.frame.height / 2))
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, offset.y, 0)
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            coverImageView.layer.transform = transform
        } else {
            coverImageView.layer.transform = CATransform3DIdentity
        }
    }
}
