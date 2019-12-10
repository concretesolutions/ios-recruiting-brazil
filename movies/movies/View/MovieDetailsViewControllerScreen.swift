//
//  MovieDetailsViewControllerScreen.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieDetailsViewControllerScreen: UIView {
    public var viewModel: MovieDetailsViewModel! {
        didSet {
            self.titleLabel.text = self.viewModel.title
            self.favoriteButton.type = self.viewModel.favorite ? .favorite  : .unfavorite
            self.dateLabel.text = self.viewModel.date
            self.genresLabel.text = self.viewModel.genres
            self.overviewLabel.text = self.viewModel.overview
            self.posterImageView.setImage(withURL: self.viewModel.posterURL)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    let posterImageView = PosterImageView()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        let font = UIFont.preferredFont(forTextStyle: .title1)
        view.font = UIFont.boldSystemFont(ofSize: font.pointSize)
        return view
    }()

    lazy var favoriteButton: FavoriteButton = {
        let view = FavoriteButton()
        view.tintColor = UIColor.systemOrange
        view.delegate = self
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return view
    }()

    lazy var genresLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
        view.textColor = .systemOrange
        return view
    }()
    
    lazy var detailsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Details"
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        return view
    }()

    lazy var overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.font = UIFont.preferredFont(forTextStyle: .body)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        self.favoriteButton.type = viewModel.favorite ? .favorite  : .unfavorite

        _ = self.viewModel.$favorite
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] favorite in
                self?.favoriteButton.type = favorite ? .favorite  : .unfavorite
            })
    }
}

// MARK: - Favorite button delegate
extension MovieDetailsViewControllerScreen: FavoriteButtonDelegate {
    func click() {
        self.viewModel.toggleFavorite()
    }
}

// MARK: - Code View
extension MovieDetailsViewControllerScreen: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(overviewLabel)
        
        scrollView.addSubview(contentView)
        
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).offset(safeAreaLayoutGuide.layoutFrame.height).multipliedBy(1.2)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(1/1.5)
            make.centerX.equalToSuperview()
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(posterImageView.snp.bottom).offset(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(favoriteButton.snp.left)
            make.centerY.equalTo(favoriteButton.snp.centerY)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.top.equalTo(genresLabel.snp.bottom).offset(30)
        }

        overviewLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(detailsLabel.snp.bottom).offset(10)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
