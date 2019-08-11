//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 09/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poster: UIImageView!
    
    private let titleViewHeightMultiplier: CGFloat = 0.20
    private var titleGradientView = UIView()
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLoopLabel: LoopScrollLabel!
    
    private let favoriteGradientViewSize = 72.0
    private var favoriteGradientView = UIView()
    @IBOutlet weak var favoriteView: UIView! {
        didSet {
            self.favoriteView.backgroundColor = UIColor.clear
            self.buildFavoriteGradientView()
        }
    }
    @IBOutlet weak var favorite: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.toggleFavorite))
            self.favorite.addGestureRecognizer(tap)
        }
    }
    
    weak var movie: MovieObject? = nil {
        didSet {
            guard let movie = self.movie else {
                return
            }
            
            self.titleLoopLabel.label.text = movie.title
            self.titleLoopLabel.triggerAnimationIfNeeded()
            self.setFavoriteImage(isFavorite: movie.isFavorite)
            if let posterData = movie.poster {
                self.poster.image = UIImage(data: posterData)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView.backgroundColor = UIColor.clear
        self.titleView.insertSubview(self.titleGradientView, at: 0)
    }
    
    func onCollectionViewLayoutUpdate(cellSize: CGSize) {
        self.buildTitleGradientView(cellSize: cellSize)
    }
    
    private func buildTitleGradientView(cellSize: CGSize) {
        self.titleGradientView.removeFromSuperview()
        
        self.titleGradientView = UIView()
        let gradientLayer = CAGradientLayer()
        
        let frameHeight = cellSize.height * titleViewHeightMultiplier
        let gradientFrame = CGRect(x: 0.0, y: 0.0, width: cellSize.width, height: frameHeight)
        
        self.titleGradientView.frame = gradientFrame
        gradientLayer.frame = gradientFrame
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.locations = [0.0, 0.45, 1.0]
        
        let bgColor = UIColor(red: 0.137, green: 0.137, blue: 0.215, alpha: 1.0)
        gradientLayer.colors = [
            bgColor.withAlphaComponent(0.0).cgColor,
            bgColor.withAlphaComponent(0.75).cgColor,
            bgColor.cgColor
        ]
        
        self.titleGradientView.layer.addSublayer(gradientLayer)
        self.titleView.insertSubview(self.titleGradientView, at: 0)
    }
    
    private func buildFavoriteGradientView() {
        self.favoriteGradientView.removeFromSuperview()
        
        self.favoriteGradientView = UIView()
        let gradientLayer = CAGradientLayer()
        
        let gradientFrame = CGRect(x: 0.0, y: 0.0, width: favoriteGradientViewSize, height: favoriteGradientViewSize)
        
        self.favoriteGradientView.frame = gradientFrame
        gradientLayer.frame = gradientFrame
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.1, y: -0.1)
        gradientLayer.locations = [0.0, 1.0]
        
        let bgColor = UIColor(red: 0.137, green: 0.137, blue: 0.215, alpha: 1.0)
        gradientLayer.colors = [
            bgColor.withAlphaComponent(0.0).cgColor,
            bgColor.cgColor
        ]
        
        self.favoriteGradientView.layer.addSublayer(gradientLayer)
        self.favoriteView.insertSubview(self.favoriteGradientView, at: 0)
    }
    
    @objc private func toggleFavorite() {
        guard let movie = self.movie else {
            return
        }

        movie.isFavorite = !movie.isFavorite
        if movie.isFavorite {
            movie.addToFavorites()
        } else {
            movie.removeFromFavorites()
        }
        
        self.setFavoriteImage(isFavorite: movie.isFavorite)
    }
    
    private func setFavoriteImage(isFavorite: Bool) {
        if isFavorite {
            self.favorite.image = UIImage(named: "FavoriteFilled")
        } else {
            self.favorite.image = UIImage(named: "FavoriteGray")
        }
    }
}
