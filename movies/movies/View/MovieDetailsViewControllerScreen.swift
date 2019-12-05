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
            self.posterImageView.kf.setImage(with: self.viewModel.posterURL, options: [.transition(.fade(0.3))])
        }
    }
    
    lazy var posterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    let favoriteButton = FavoriteButton()
    
    let titleDivider = Divider()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    let dateDivider = Divider()
    
    lazy var genresLabel: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    let genresDivider = Divider()
    
    lazy var overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        favoriteButton.delegate = self
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
        addSubview(posterImageView)
        addSubview(favoriteButton)
        addSubview(titleLabel)
        addSubview(titleDivider)
        addSubview(dateLabel)
        addSubview(dateDivider)
        addSubview(genresLabel)
        addSubview(genresDivider)
        addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalToSuperview().multipliedBy(0.4)
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
        
        titleDivider.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.top.equalTo(titleDivider.snp.bottom).offset(10)
        }
        
        dateDivider.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.top.equalTo(dateDivider.snp.bottom).offset(10)
        }
        
        genresDivider.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(genresLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(genresDivider.snp.bottom).offset(10)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
