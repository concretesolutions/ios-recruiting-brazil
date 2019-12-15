//
//  MovieDetailView.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 15/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    let scrollView = UIScrollView()
    let movieImageView = UIImageView()
    let title = UILabel()
    let year = UILabel()
    let genders = UILabel()
    let overview = UILabel()
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        return button
    }()
    var favoriteAction: ((_ isFavorite: Bool) -> Void)?
    var isFavorite = false
    
    init(with movie: Movie) {
        super.init(frame: .zero)
        movieImageView.image = UIImage(data: movie.movieImageData ?? Data())
        title.text = movie.title ?? movie.name
        year.text = (movie.releaseDate ?? "").year
        overview.text = movie.overview
        changeFavoriteIcon(isAdding: movie.isFavorite ?? false)
        isFavorite = movie.isFavorite ?? false
    }
    
    init(with favoriteMovie: FavoriteMovie) {
        super.init(frame: .zero)
        movieImageView.image = UIImage(data: favoriteMovie.image ?? Data())
        title.text = favoriteMovie.title
        year.text = favoriteMovie.year
        overview.text = favoriteMovie.descript
        isFavorite = true
        changeFavoriteIcon(isAdding: isFavorite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        setupView()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc func favoriteButtonTapped() {
        isFavorite = !isFavorite
        favoriteAction?(isFavorite)
        changeFavoriteIcon(isAdding: isFavorite)
    }
    
    func changeFavoriteIcon(isAdding: Bool) {
        let imageName: String = isAdding ? "favorite_full_icon" : "favorite_gray_icon"
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension MovieDetailView: ViewCode {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubviews([movieImageView, title, favoriteButton,
                                year, genders, overview])
    }
    
    func buildConstraints() {
        scrollView.anchor.attatch(to: safeAreaLayoutGuide)
        
        let imgWidth: CGFloat = 250
        let imgHeight: CGFloat = imgWidth * 1.3
        movieImageView.anchor
            .top(scrollView.topAnchor, padding: 16)
            .centerX(scrollView.centerXAnchor)
            .width(constant: imgWidth)
            .height(constant: imgHeight)
        
        title.anchor
            .top(movieImageView.bottomAnchor, padding: 16)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(favoriteButton.leftAnchor, padding: 16)
        
        favoriteButton.anchor
            .top(movieImageView.bottomAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .width(constant: 20)
            .height(constant: 20)
        
        year.anchor
            .top(title.bottomAnchor, padding: 16)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
        
        genders.anchor
            .top(year.bottomAnchor, padding: 16)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
        
        overview.anchor
            .top(genders.bottomAnchor, padding: 16)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .bottom(scrollView.bottomAnchor, padding: 16)
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        genders.numberOfLines = 0
        overview.numberOfLines = 0
        
    }
}
