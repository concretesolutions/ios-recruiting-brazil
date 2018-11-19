//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import SnapKit
import Reusable
import SDWebImage

class PopularMoviesCollectionViewCell: UICollectionViewCell, Reusable {
    
    var movie: Movie!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setup(movie: Movie) {
        self.movie = movie
        setupView()
    }
    
}

extension PopularMoviesCollectionViewCell: CodeView {
    
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + movie.thumbFilePath), completed: nil)
    }
    
}
