//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Lucca Ferreira on 03/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import Combine

class FavoritesTableViewCell: UITableViewCell {

    private var viewModel: FavoriteMoviesCellViewModel! {
        didSet {
            self.movieTitle.text = self.viewModel.title
            self.movieReleaseYear.text = self.viewModel.releaseYear
            self.movieOverview.text = self.viewModel.overview
            self.setCombine()
        }
    }

    private var posterImageCancellable: AnyCancellable?

    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    let contentContainerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10.0
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage()
        return imageView
    }()

    private let textualContentContainerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let titleContainer: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .top
        return stackView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let movieOverview: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private let movieReleaseYear: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(withViewModel viewModel: FavoriteMoviesCellViewModel) {
        self.viewModel = viewModel
    }

    private func setCombine() {
        self.posterImageCancellable = self.viewModel.posterImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image!, on: posterImageView)
    }

    override func prepareForReuse() {
        self.posterImageView.image = UIImage(named: "imagePlaceholder")
    }
    
    @objc func touchLikeButton() {
        self.viewModel.toggleFavorite()
    }
    
    func toggleFavorite() {
        self.viewModel.toggleFavorite()
    }
    
}

extension FavoritesTableViewCell: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.posterImageView)
        self.containerView.addSubview(self.textualContentContainerView)
        self.textualContentContainerView.addSubview(self.titleContainer)
        self.titleContainer.addArrangedSubview(self.movieTitle)
        self.titleContainer.addArrangedSubview(self.movieReleaseYear)
        self.textualContentContainerView.addSubview(movieOverview)
    }

    func setupConstraints() {
        self.containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        self.posterImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(self.posterImageView.snp.height).multipliedBy(0.8)
        }
        self.textualContentContainerView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview().inset(10.0)
            make.left.equalTo(self.posterImageView.snp.right).offset(10.0)
        }
        self.titleContainer.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.movieOverview.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(self.titleContainer.snp.bottom).offset(4.0)
        }
    }

    func setupAdditionalConfiguration() {
        
    }

}
