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
            self.posterImageView.setImage(withURL: self.viewModel.posterURL)
            self.favoriteButton.delegate = self.viewModel
        }
    }
    
    let posterImageView = PosterImageView()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Title"
        view.textAlignment = .center
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return view
    }()
    
    lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 10
        
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    
    let favoriteButton = FavoriteButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
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

// MARK: - Code View
extension MovieCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        container.addSubview(favoriteButton)
        addSubview(container)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalTo(titleLabel.snp.top).offset(-10)
            make.width.equalTo(posterImageView.snp.height).dividedBy(1.5)
            make.centerX.equalToSuperview()
        }
        
        container.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.height.width.equalTo(posterImageView.snp.width).multipliedBy(0.2)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.right.equalToSuperview().inset(5)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
