//
//  PopularMoviesCollectionViewCell.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class PopularMoviesCollectionViewCell: UICollectionViewCell {

    private var viewModel: PopularMoviesCellViewModel! {
        didSet {
            self.movieTitle.text = self.viewModel.title
            self.setCombine()
        }
    }

    private var posterImageCancellable: AnyCancellable?
    private var likeButtonCancellable: AnyCancellable?

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        return stackView
    }()

    @Published private var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16.0
        imageView.image = UIImage()  //Problem related with combine assign operation
        return imageView
    }()

    private let movieTitleContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    private let movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .label
        return label
    }()

    @Published var likeButton: LikeButton = {
        let button = LikeButton()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(withViewModel viewModel: PopularMoviesCellViewModel) {
        self.viewModel = viewModel
        self.likeButton.addTarget(self, action: #selector(touchLikeButton), for: .touchUpInside)
    }

    private func setCombine() {
        self.posterImageCancellable = self.viewModel.posterImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image!, on: posterImageView)
        self.likeButtonCancellable = self.viewModel.$isLiked
            .assign(to: \.isSelected, on: self.likeButton)
    }

    @objc func touchLikeButton() {
        self.viewModel.toggleFavorite()
    }

    override func prepareForReuse() {
        self.posterImageView.image = UIImage(named: "imagePlaceholder")
    }

}

extension PopularMoviesCollectionViewCell: ViewCode {

    func buildViewHierarchy() {
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(posterImageView)
        verticalStackView.addArrangedSubview(movieTitleContainer)
        self.movieTitleContainer.addSubview(movieTitle)
        self.contentView.addSubview(likeButton)
    }

    func setupConstraints() {
        self.verticalStackView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        self.movieTitleContainer.snp.makeConstraints { (make) in
            make.height.equalTo(56.0)
        }
        self.movieTitle.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        self.likeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10.0)
            make.right.equalToSuperview().inset(10.0)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 16.0
    }

}
