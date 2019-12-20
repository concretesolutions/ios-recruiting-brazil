//
//  MovieCell.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Subviews
    lazy var posterImage: UIImageView = {
        let view = UIImageView(image: nil)
        return view
    }()
    
    lazy var posterGradientLayer: UIImageView = {
       let view = UIImageView(image: UIImage(named: "PosterGradient"))
       return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byTruncatingTail
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = FavoriteButton(baseTintColor: .white)
        button.addTarget(self,
                         action: #selector(didFavoriteMovie),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Stacks
    lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - Attributes
    var movie: Movie?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup cell content
    func setup(with movie: Movie) {
        self.movie = movie
        self.title.text = movie.title
        self.favoriteButton.isSelected = movie.isFavorite
        let dataService = DataService.shared
        if let posterPath =  movie.posterPath {
            dataService.loadPosterImage(with: posterPath) { (image) in
                movie.posterImage = image
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            }
        } else {
            movie.posterImage = UIImage(named: "PosterUnavailabe")
            self.posterImage.image = movie.posterImage
        }
    }
    
    override func prepareForReuse() {
        self.posterImage.image = nil
        self.title.text = nil
        self.favoriteButton.isSelected = false
    }
    
    // MARK: - Favorite
    @objc func didFavoriteMovie() {
        guard let movie = self.movie else {
            return
        }
        
        self.favoriteButton.isSelected = !self.favoriteButton.isSelected
        let dataService = DataService.shared
        movie.isFavorite = !movie.isFavorite
        
        if self.favoriteButton.isSelected {
            dataService.addToFavorites(movie.id)
        } else {
            dataService.removeFromFavorites(movie.id)
        }
    }
}

extension MovieCell: CodeView {
    func buildViewHierarchy() {
        // Poster image
        self.posterImage.addSubview(self.posterGradientLayer)
        
        // Info container
        self.infoStack.addArrangedSubview(self.title)
        self.infoStack.addArrangedSubview(self.favoriteButton)
        
        // View
        self.contentView.addSubview(self.posterImage)
        self.contentView.addSubview(self.infoStack)
    }
    
    func setupConstraints() {
        self.posterImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.posterGradientLayer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.infoStack.snp.makeConstraints { (make) in
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.2)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        self.favoriteButton.snp.makeConstraints { (make) in
            make.height.equalTo(36)
            make.width.equalTo(40)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
