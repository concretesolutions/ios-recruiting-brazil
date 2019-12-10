//
//  MoviesCollectionViewCell.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class MoviesCollectionViewCell: UICollectionViewCell {

    private var viewModel: MoviesCollectionCellViewModel!
    private var cancellables: [AnyCancellable] = []

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
        imageView.image = UIImage()  //Problem related
        return imageView
    }()

    private let movieTitleContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    private let movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .natural
        return label
    }()

    @Published private var likeButton: LikeButton = {
        let button = LikeButton()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
        self.backgroundColor = UIColor(named: "cellBackground")
        self.layer.cornerRadius = 16.0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(withViewModel viewModel: MoviesCollectionCellViewModel) {
        self.viewModel = viewModel
        self.movieTitle.text = self.viewModel.title
        likeButton.addTarget(self, action: #selector(touchLikeButton), for: .touchUpInside)
        self.setCombine()
    }

    private func setCombine() {
        let posterImageCancellable = self.viewModel.$posterImage
            .receive(on: RunLoop.main)
            .assign(to: \.image!, on: posterImageView)
        let likeButtonCancellable = self.viewModel.$isLiked.assign(to: \.isSelected, on: likeButton)
        self.cancellables.append(posterImageCancellable)
        self.cancellables.append(likeButtonCancellable)
    }

    @objc func touchLikeButton() {
        print("Cliquei")
    }

}

extension MoviesCollectionViewCell: ViewCode {

    func buildViewHierarchy() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(posterImageView)
        verticalStackView.addArrangedSubview(movieTitleContainer)
        self.movieTitleContainer.addSubview(movieTitle)
        self.posterImageView.addSubview(likeButton)
    }

    func setupContraints() {
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

    func setupAdditionalConfiguration() {}

}
