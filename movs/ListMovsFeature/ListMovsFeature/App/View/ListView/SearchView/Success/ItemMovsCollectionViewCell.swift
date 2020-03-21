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
    
    public var favoriteMovie: ((_ viewData: MovsItemViewData) -> Void)?
    //MARK: Model
    var model: MovsItemViewData? {
        didSet {
            self.fillUpUI()
        }
    }
    
    //MARK: Create UI
    var posterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.Images.defaultImageMovs
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
        label.font = FontAssets.avenirTextCell
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = Colors.yellowLight
        return label
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton()
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
            self.viewContent.leadingAnchor.constraint(equalTo: self.posterUIImageView.leadingAnchor),
            self.viewContent.trailingAnchor.constraint(equalTo: self.posterUIImageView.trailingAnchor),
            self.viewContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.titleMovieLabel.topAnchor.constraint(equalTo: self.viewContent.topAnchor),
            self.titleMovieLabel.leadingAnchor.constraint(equalTo: self.viewContent.leadingAnchor, constant: 2),
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
        
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addSubview(self.posterUIImageView)
        self.addSubview(self.viewContent)
        
        self.viewContent.addSubview(self.titleMovieLabel)
        self.viewContent.addSubview(self.favoriteButton)
        self.makeConstraints()
                
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchDown)
    }
}

//MARK: - Events UI -
extension ItemMovsCollectionViewCell {
    @objc func didTapFavoriteButton() {
        if var model = self.model {
            
            model.isFavorite.toggle()
                        
            UIView.animate(withDuration: 0.6,
            animations: {
                self.favoriteButton.setImage(Assets.Images.favoriteFullIcon, for: .normal)
                self.favoriteButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            },
            completion: { _ in
                
                UIView.animate(withDuration: 0.6, animations: {
                    self.favoriteButton.transform = CGAffineTransform.identity
                }) { _ in
                    self.favoriteMovie?(model)
                }
            })
            
        }
    }
}

//MARK: - Privates -
extension ItemMovsCollectionViewCell {
    
    private func fillUpUI() {
        self.titleMovieLabel.text = model?.movieName
                    
        if model?.isFavorite ?? false {
            favoriteButton.setImage(Assets.Images.favoriteFullIcon, for: .normal)
        } else {
            favoriteButton.setImage(Assets.Images.favoriteGrayIcon, for: .normal)
        }
        
        self.loadImage()
    }
    
    private func loadImage() {
        
        guard let urlString = self.model?.imageMovieURLAbsolute else { return }
        
        //Load from cache
        if let image = ImageCache.shared.getImage(in: urlString) {
            self.posterUIImageView.image = image
            return
        }
        self.isLoadingImage = true
        
        self.nsLoadImage.loadImage(absoluteUrl: urlString) { [weak self] data in
            self?.setImage(with: data, andUrl: urlString)
        }
    }
    
    private func setImage(with data: Data?, andUrl urlString: String) {
        DispatchQueue.main.async {
            if let data = data,
                let image = UIImage(data: data) {
                ImageCache.shared.setImage(image, in: urlString)
                self.posterUIImageView.image = image
                self.isLoadingImage = false
            } else {
                self.posterUIImageView.image = Assets.Images.defaultImageMovs
            }
            
        }
    }
}

