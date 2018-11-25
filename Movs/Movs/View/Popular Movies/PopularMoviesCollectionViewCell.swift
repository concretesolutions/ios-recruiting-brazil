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
    
    //MARK: - Properties
    // Data
    var movie: Movie!
    
    //MARK: - Interface
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var detailView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Design.colors.dark.withAlphaComponent(0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Design.colors.mainYellow
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = false
        button.imageView?.contentMode = .scaleToFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Setup
    func setup(movie: Movie) {
        self.movie = movie
        setupView()
    }
    
}

//MARK: - CodeView
extension PopularMoviesCollectionViewCell: CodeView {
    
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(detailView)
        detailView.addSubview(titleLabel)
        detailView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        detailView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(imageView.snp.height).multipliedBy(0.30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        // download thumbnail
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + (movie.thumbFilePath ?? "")), placeholderImage: UIImage(named: "placeholder_poster")!, options: .progressiveDownload , completed: nil)
        
        // set title label text
        titleLabel.text = movie.title
        
        // set button image
        if movie.isFavorite {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon")!, for: .normal)
        }
    }
    
}
