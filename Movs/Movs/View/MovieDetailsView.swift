//
//  MovieDetailsView.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Combine
import UIKit

class MovieDetailsView: UIView {

    private var viewModel: MovieDetailsViewModel!

    @Published private var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16.0
        imageView.image = UIImage() //Problem related with combine operators
        return imageView
    }()
    
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    private let movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.numberOfLines = 5
        return label
    }()

    private let movieReleaseYear: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        return label
    }()
    
    private let movieOverview: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.isEditable = false
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.textContainer.lineFragmentPadding = 0
        view.textContainerInset = .zero
        view.textColor = .label
        return view
    }()
    
    private let movieGenres: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .natural
        label.numberOfLines = 4
        return label
    }()
    
    @Published private var likeButton: LikeButton = {
        let button = LikeButton()
        return button
    }()
    
    private(set) var likeButtonCancellable: AnyCancellable?
    private(set) var posterImageCancellable: AnyCancellable?

    required init(withViewModel viewModel: MovieDetailsViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        self.setCombine()
        self.likeButton.addTarget(self, action: #selector(touchLikeButton), for: .touchUpInside)
        self.movieTitle.text = viewModel.title
        self.movieReleaseYear.text = viewModel.releaseYear
        self.movieGenres.text = self.viewModel.genres
        self.movieOverview.text = viewModel.overview
    }
    
    required init(withFrame frame: CGRect, withViewModel viewModel: MovieDetailsViewModel) {
        super.init(frame: frame)
        self.viewModel = viewModel
        self.setCombine()
        self.likeButton.addTarget(self, action: #selector(touchLikeButton), for: .touchUpInside)
        self.movieTitle.text = viewModel.title
        self.movieReleaseYear.text = viewModel.releaseYear
        self.movieGenres.text = self.viewModel.genres
        self.movieOverview.text = viewModel.overview
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupView()
    }
    
    private func setCombine() {
        self.posterImageCancellable = self.viewModel.posterImage
            .receive(on: RunLoop.main)
            .assign(to: \.image!, on: posterImageView)
        self.likeButtonCancellable = self.viewModel.$isLiked
            .assign(to: \.isSelected, on: likeButton)
    }
    
    @objc func touchLikeButton() {
        self.viewModel.toggleFavorite()
    }
    
}

extension MovieDetailsView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.likeButton)
        self.contentView.addSubview(self.movieTitle)
        self.contentView.addSubview(self.movieReleaseYear)
        self.contentView.addSubview(self.movieGenres)
        self.contentView.addSubview(self.movieOverview)
    }

    func setupConstraints() {
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        self.posterImageView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(self.posterImageView.snp.width).multipliedBy(1.7)
        }
        self.likeButton.snp.makeConstraints { (make) in
            make.top.right.equalTo(self.posterImageView).inset(16)
        }
        self.movieTitle.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        self.movieReleaseYear.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(self.movieTitle.snp.bottom).offset(16)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        self.movieGenres.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(self.movieReleaseYear.snp.bottom).offset(16)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        self.movieOverview.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.top.equalTo(self.posterImageView.snp.bottom).offset(16).priority(.medium)
            make.top.greaterThanOrEqualTo(self.movieGenres.snp.bottom).offset(16).priority(.required)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
    
}
