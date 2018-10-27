//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    let movieView = MovieBoxView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func set(movie: MovieListModel.ViewModel.Movie) {
        let url = URL(string: movie.posterURL)!
        movieView.title.text = movie.title
        movieView.movieImage.kf.setImage(with: url)
    }
    
}

extension MovieCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(movieView)
    }
    
    func setupConstraints() {
        movieView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
