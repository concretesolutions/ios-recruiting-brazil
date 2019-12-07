//
//  PopularMovieCollectionViewCell.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Interface Elements
    
    internal lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        title.textColor = UIColor.label
        return title
    }()
    
    internal lazy var poster: UIImageView = {
        let poster = UIImageView(frame: .zero)
        poster.layer.cornerRadius = 4.0
        poster.layer.masksToBounds = true
        return poster
    }()
    
    internal lazy var favoriteButton: FavoriteButton = {
        let button = FavoriteButton(frame: .zero)
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Properties
    
    internal var viewModel: MovieCellViewModel! {
        didSet {
            self.titleLabel.text = self.viewModel.title
            self.bind(to: self.viewModel)
        }
    }
    
    // MARK: - Subscribers

    var posterSubscriber: AnyCancellable?
    
    // MARK: - Initializers and Deinitializers
        
    override required init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.posterSubscriber?.cancel()
    }
    
    // MARK: - Binding
    
    func bind(to viewModel: MovieCellViewModel) {
        self.posterSubscriber = viewModel.$posterImage
            .receive(on: RunLoop.main)
            .sink(receiveValue: { image in
                self.poster.image = image
            })
    }
}

extension PopularMovieCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.poster)
        self.contentView.addSubview(self.favoriteButton)
        self.contentView.addSubview(self.titleLabel)
    }
    
    func setupConstraints() {
        self.poster.snp.makeConstraints({ make in
            make.top.centerX.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.85)
        })
        
        self.favoriteButton.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
            make.bottom.trailing.equalTo(self.poster).inset(8.0)
        })
        
        self.titleLabel.snp.makeConstraints({ make in
            make.width.centerX.equalTo(self)
            make.top.equalTo(self.poster.snp.bottom).offset(4.0)
        })
    }
}
