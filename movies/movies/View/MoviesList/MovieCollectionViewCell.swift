//
//  MovieCollectionViewCell.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import SnapKit
import Combine
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    private var viewModel: MovieCellViewModel! {
        didSet {
            self.titleLabel.text = self.viewModel.title
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
        view.text = "Title"
        return view
    }()
    
    let favoriteButton = FavoriteButton()
    
    lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemFill
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
    
    func setViewModel(_ viewModel: MovieCellViewModel) {
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
extension MovieCollectionViewCell: FavoriteButtonDelegate {
    func click() {
        self.viewModel.toggleFavorite()
    }
}

// MARK: - Code View
extension MovieCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(posterImageView)
        container.addSubview(titleLabel)
        container.addSubview(favoriteButton)
        addSubview(container)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        container.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.right.equalToSuperview().inset(5)
            make.width.equalTo(favoriteButton.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(favoriteButton.snp.left)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemYellow
    }
}

