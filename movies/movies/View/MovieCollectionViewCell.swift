//
//  MovieCollectionViewCell.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    public var viewModel: MovieCellViewModel! {
        didSet {
            self.posterImageView.image = UIImage(data: self.viewModel.poster)
            self.titleLabel.text = self.viewModel.title
            self.favoriteButton.type = self.viewModel.favorite ? .favorite  : .unfavorite
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
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let favoriteButton = FavoriteButton()
    
    lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemFill
        return view
    }()
    
    convenience init(with viewModel: MovieCellViewModel) {
        self.init(frame: .zero)
        
        defer {
            self.viewModel = viewModel
        }
        
        setupView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setupView()
    }
}

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
            make.centerX.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemYellow
    }
}
