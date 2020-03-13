//
//  ItemMovsCollectionViewCell.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import CommonsModule
import NetworkLayerModule
import AssertModule

class ItemMovsCollectionViewCell: UICollectionViewCell {
            
    //MARK: Private
    private let nsLoadImage = NLLoadImage()
    private var isLoadingImage: Bool = false
    
    
    //MARK: Model
    var model: MovsItemViewData? {
        didSet {
            self.titleMovieLabel.text = model?.movieName
                        
            if model?.isFavorite ?? false {
                favoriteButton.setImage(Assets.Images.favoriteFullIcon, for: .normal)
            } else {
                favoriteButton.setImage(Assets.Images.favoriteGrayIcon, for: .normal)
            }
            
            self.loadImage()
        }
    }
    
    //MARK: Create UI
    var posterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Colors.blueDark
        return imageView
    }()
    
    var viewContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.blueDark
        return view
    }()
    
    var titleMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thor"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textAlignment = .center
        label.textColor = Colors.yellowLight
        return label
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

//MARK - Contraints -
extension ItemMovsCollectionViewCell {
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            self.posterUIImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            self.posterUIImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            self.posterUIImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            self.posterUIImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            self.viewContent.topAnchor.constraint(equalTo: self.posterUIImageView.bottomAnchor),
            self.viewContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.viewContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.viewContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.titleMovieLabel.topAnchor.constraint(equalTo: self.viewContent.topAnchor),
            self.titleMovieLabel.leadingAnchor.constraint(equalTo: self.viewContent.leadingAnchor),
            self.titleMovieLabel.trailingAnchor.constraint(equalTo: self.favoriteButton.leadingAnchor, constant: -2),
            self.titleMovieLabel.bottomAnchor.constraint(equalTo: self.viewContent.bottomAnchor),
            
            self.favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.viewContent.centerYAnchor),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.viewContent.trailingAnchor, constant: -2)
            
        ])
    }
}

//MARK: - Lifecycle -
extension ItemMovsCollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        if isLoadingImage {
            nsLoadImage.cancelLoadImage()
        }
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.posterUIImageView)
        self.addSubview(self.viewContent)
        
        self.viewContent.addSubview(self.titleMovieLabel)
        self.viewContent.addSubview(self.favoriteButton)
        self.makeConstraints()
                
    }
}

//MARK: - Events UI -
extension ItemMovsCollectionViewCell {
    @objc func didTapFavoriteButton() {
        print("Favoritou")
    }
}

//MARK: - Privates -
extension ItemMovsCollectionViewCell {
    private func loadImage() {
        
        guard let urlString = self.model?.imageMovieURLAbsolute else { return }
        
        //Load from cache
        if let image = ImageCache.shared.getImage(in: urlString) {
            self.posterUIImageView.image = image
            return
        }
        self.isLoadingImage = true
        
        self.nsLoadImage.loadImage(absoluteUrl: urlString) { data in
            DispatchQueue.main.async {
                guard let data = data,
                    let image = UIImage(data: data) else { return }
                ImageCache.shared.setImage(image, in: urlString)
                self.posterUIImageView.image = image
                self.isLoadingImage = false
            }
        }
    }
}

