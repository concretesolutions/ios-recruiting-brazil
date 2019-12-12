//
//  MovieDetailScreen.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 08/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import SnapKit
import UIKit

final class MovieDetailScreen: UIView {

    // MARK: - Delegate

    weak var delegate: HeartButtonDelegate?

    // MARK: - Model

    private var movie: Movie!

    // MARK: - Subviews

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .systemGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private lazy var titleHeartStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 10.0
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        view.numberOfLines = 0
        return view
    }()

    private lazy var heartButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.tintColor = UIColor(named: "Yellow")
        view.addTarget(self, action: #selector(self.didTapOnHeart), for: .touchUpInside)
        return view
    }()

    private lazy var yearLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        view.textColor = .systemGray
        return view
    }()

    private lazy var genresLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        view.textColor = .systemGray
        view.numberOfLines = 0
        return view
    }()

    private lazy var overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textAlignment = .natural
        return view
    }()

    private lazy var separators: [UIView] = []

    // MARK: - Initializers

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration methods

    func configure(with movie: Movie) {
        self.movie = movie
        self.posterImageView.loadImage(fromURL: self.movie.bigImageURL)
        self.titleLabel.text = self.movie.title
        self.configureHeartImage()
        self.yearLabel.text = self.movie.releaseYear
        self.configureGenres()
        self.overviewLabel.text = self.movie.overview
    }

    private func configureHeartImage() {
        let imageName = self.movie.isFavourite ? "heart.fill" : "heart"
        self.heartButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
    }

    private func configureGenres() {
        let group = DispatchGroup()
        var genres: String = ""

        for (i, id) in self.movie.genreIds.enumerated() {
            group.enter()
            DataProvider.shared.genre(forId: id) { genre in
                if let genre = genre {
                    genres += genre
                    if i < self.movie.genreIds.count-1 {
                        genres += " | "
                    }
                }

                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.global()) {
            DispatchQueue.main.async {
                self.genresLabel.text = genres
            }
        }
    }
}

extension MovieDetailScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.posterImageView)
        self.scrollView.addSubview(self.titleHeartStack)
        self.titleHeartStack.addArrangedSubview(self.titleLabel)
        self.titleHeartStack.addArrangedSubview(self.heartButton)
        self.scrollView.addSubview(self.yearLabel)
        self.scrollView.addSubview(self.genresLabel)
        self.scrollView.addSubview(self.overviewLabel)
    }

    func setupContraints() {

        // scrolLView

        self.scrollView.snp.makeConstraints { maker in
            maker.top.equalTo(self.safeAreaLayoutGuide)
            maker.bottom.equalTo(self.safeAreaLayoutGuide)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }

        // posterImageView

        self.posterImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalTo(UIScreen.main.bounds.height*0.5)
        }

        // titleHeartStack

        self.titleHeartStack.snp.makeConstraints { maker in
            maker.top.equalTo(self.posterImageView.snp.bottom).offset(10)
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().inset(10)
        }

        // heartButton

        self.heartButton.snp.makeConstraints { maker in
            maker.width.equalTo(30)
            maker.height.equalTo(self.heartButton.snp.width).multipliedBy(0.93)
        }

        // yearLabel

        self.yearLabel.snp.makeConstraints { maker in
            maker.top.equalTo(self.titleHeartStack.snp.bottom).offset(4)
            maker.leading.equalTo(self.titleHeartStack)
            maker.trailing.equalTo(self.titleHeartStack)
        }

        // genresLabel

        self.genresLabel.snp.makeConstraints { maker in
            maker.top.equalTo(self.yearLabel.snp.bottom).offset(6)
            maker.leading.equalTo(self.titleHeartStack)
            maker.trailing.equalTo(self.titleHeartStack)
        }

        // overviewLabel

        self.overviewLabel.snp.makeConstraints { maker in
            maker.top.equalTo(self.genresLabel.snp.bottom).offset(15)
            maker.leading.equalTo(self.titleHeartStack)
            maker.trailing.equalTo(self.titleHeartStack)
            maker.bottom.equalToSuperview().inset(15)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}

extension MovieDetailScreen: UIGestureRecognizerDelegate {

    // MARK: - Tap handlers

    @objc func didTapOnHeart() {
        self.movie.isFavourite = self.movie.isFavourite ? false : true
        self.configureHeartImage()
        self.delegate?.didTapOnHeart(movieID: self.movie.id)
    }
}
