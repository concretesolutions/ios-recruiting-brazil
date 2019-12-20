//
//  FavoriteMovieCell.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 19/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import SnapKit
import UIKit

final class FavoriteMovieCell: UITableViewCell {

    // MARK: - Model

    private var movie: Movie!

    // MARK: - Reusable Identifier

    static let reusableIdentifier: String = "FavoriteMovieCell"

    // MARK: - Subviews

    private lazy var posterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .systemGray
        return view
    }()

    private lazy var detailStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = 10.0
        return view
    }()

    private lazy var titleYearStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .top
        view.distribution = .fill
        view.spacing = 10.0
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        view.textColor = UIColor(named: "Yellow")
        view.numberOfLines = 1
        return view
    }()

    private lazy var yearLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        view.textColor = UIColor(named: "Yellow")
        view.textAlignment = .right
        view.numberOfLines = 1
        return view
    }()

    private lazy var overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = UIColor(named: "Gray")
        view.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        view.textAlignment = .natural
        view.numberOfLines = 3
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.imageView?.backgroundColor = .systemRed
        self.selectionStyle = .none
        self.setupView()
    }

    convenience init(frame: CGRect) {
        self.init(style: .default, reuseIdentifier: FavoriteMovieCell.reusableIdentifier)
        self.frame = frame
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration methods

    func configure(with movie: Movie) {
        self.movie = movie

        self.titleLabel.text = self.movie.title
        self.yearLabel.text = self.movie.releaseYear
        self.overviewLabel.text = self.movie.overview
        self.posterImageView.loadImage(fromURL: self.movie.smallImageURL)
    }
}

extension FavoriteMovieCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.posterImageView)
        self.addSubview(self.detailStack)
        self.detailStack.addArrangedSubview(self.titleYearStack)
        self.titleYearStack.addArrangedSubview(self.titleLabel)
        self.titleYearStack.addArrangedSubview(self.yearLabel)
        self.detailStack.addArrangedSubview(self.overviewLabel)
    }

    func setupContraints() {

        // posterImageView

        self.posterImageView.snp.makeConstraints { maker in
            maker.top.bottom.leading.equalToSuperview()
            maker.width.equalTo(self.posterImageView.snp.height).multipliedBy(0.7)
        }

        // detailStack

        self.detailStack.snp.makeConstraints { maker in
            maker.top.trailing.equalToSuperview().inset(16)
            maker.bottom.lessThanOrEqualToSuperview().inset(16)
            maker.leading.equalTo(self.posterImageView.snp.trailing).offset(16)
        }

        // titleYearStack

        self.titleYearStack.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
        }

        // titleLabel

        self.titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor(named: "Blue")
    }
}
