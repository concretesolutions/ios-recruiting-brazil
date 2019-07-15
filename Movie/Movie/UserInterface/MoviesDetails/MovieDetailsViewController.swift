//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var backdropImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    var yearLabel: UILabel = UILabel()
    var favoriteButton: UIButton = UIButton()
    var genreLabel: UILabel = UILabel()
    
    var viewModel: MovieDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        
        self.setupVisualComponents()
        self.viewModel?.fetchMovieDetails()
        self.viewModel?.delegate = self
    }
    
    func setupVisualComponents() {
        [
            backdropImageView,
            titleLabel,
            descriptionLabel,
            yearLabel,
            favoriteButton,
            genreLabel
        ].forEach(self.view.addSubview)
        
        self.backdropImageView.contentMode = .scaleAspectFit
        self.backdropImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view).inset(15)
            make.height.equalTo(self.backdropImageView.snp.width).multipliedBy(0.6)
        }
        
        self.titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.backdropImageView)
            make.top.equalTo(self.backdropImageView.snp.bottom).offset(15)
            
        }
        
        
        self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .highlighted)
        self.favoriteButton.addTarget(self, action: #selector(self.didTapInFavoriteButton), for: .touchUpInside)
        
        self.favoriteButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right)
            make.right.equalTo(self.backdropImageView)
            make.width.equalTo(self.favoriteButton.snp.height)
            make.centerY.equalTo(self.titleLabel)
        }
        
        self.yearLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        self.yearLabel.textColor = .gray
        self.yearLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
        
        self.genreLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        self.genreLabel.textColor = .black
        self.genreLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.yearLabel.snp.bottom).offset(5)
        }
        
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.genreLabel.snp.bottom).offset(15)
            make.left.right.equalTo(self.backdropImageView)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
    }
    
    
    
    @objc func didTapInFavoriteButton() {
        self.viewModel?.handleFavoriteAction()
    }
    

   

}

extension MovieDetailsViewController: MovieDetailsDelegate {
    func setupView() {
        if let viewModel = self.viewModel {
            self.backdropImageView.image = viewModel.image
            self.favoriteButton.isHighlighted = viewModel.isFavorited
            self.titleLabel.text = viewModel.name
            self.descriptionLabel.text = viewModel.description
            self.yearLabel.text = viewModel.year
            self.genreLabel.text = viewModel.genre
        }
        
    }
    
    func updateUIFavoriteState() {
        if let viewModel = self.viewModel {
            DispatchQueue.main.async {
                self.favoriteButton.isHighlighted = viewModel.isFavorited
            }
        }
        
    }
}
