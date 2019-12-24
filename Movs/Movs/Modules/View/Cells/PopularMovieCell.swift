//
//  PopularMovieCell.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 05/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import SnapKit
import UIKit

class PopularMovieCell: UICollectionViewCell {

    // MARK: - Model

    private var movie: Movie!

    // MARK: - Reusable Identifier

    static let reuseIdentifier: String = "PopularMovieCell"

    // MARK: - Subviews

    private lazy var mainStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 0.0
        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .systemGray
        return view
    }()

    private lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray3
        return view
    }()

    private lazy var bottomStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 10.0
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        view.numberOfLines = 2
        return view
    }()

    private lazy var heartButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.tintColor = .systemIndigo
        view.addTarget(self, action: #selector(self.didTapOnHeart), for: .touchUpInside)
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration methods

    func configure(with movie: Movie) {
        self.movie = movie
        self.movie.didSetIsFavorite = {
            DispatchQueue.main.async {
                self.configureHeartImage()
            }
        }

        self.titleLabel.text = movie.title
        self.posterImageView.image = nil
        self.posterImageView.loadImage(fromURL: movie.smallImageURL)
        self.configureHeartImage()
    }

    private func configureHeartImage() {
        let imageName = self.movie.isFavorite ? "heart.fill" : "heart"
        self.heartButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
    }
}

// MARK: - CodeView

extension PopularMovieCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.mainStack)
        self.mainStack.addArrangedSubview(self.posterImageView)
        self.mainStack.addArrangedSubview(self.bottomView)
        self.bottomView.addSubview(self.bottomStack)
        self.bottomStack.addArrangedSubview(self.titleLabel)
        self.bottomStack.addArrangedSubview(self.heartButton)
    }

    func setupContraints() {
        self.mainStack.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }

        self.bottomView.snp.makeConstraints { maker in
            maker.height.equalTo(60)
        }

        self.bottomStack.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leadingMargin.equalToSuperview()
            maker.trailingMargin.equalToSuperview()
        }

        self.heartButton.snp.makeConstraints { maker in
            maker.width.equalTo(30)
            maker.height.equalTo(self.heartButton.snp.width).multipliedBy(0.93)
        }
    }

    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = true
    }
}

extension PopularMovieCell: UIGestureRecognizerDelegate {

    // MARK: - Tap handlers

    @objc func didTapOnHeart() {
        self.movie.isFavorite = self.movie.isFavorite ? false : true
        self.configureHeartImage()
    }
}
