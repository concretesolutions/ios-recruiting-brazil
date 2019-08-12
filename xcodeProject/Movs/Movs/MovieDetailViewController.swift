//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 11/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController, MovieUpdateListener {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieObject: MovieObject? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        guard let movie = self.movieObject else {
            return
        }
        movie.registerAsListener(self)
        
        self.title = movie.title
        self.genresLabel.text = movie.genresDescription()
        self.overviewLabel.text = movie.overview
        
        if let release = movie.release {
            self.releaseLabel.text = String(Calendar.current.component(.year, from: release))
        }
        
        if let posterData = movie.poster {
            self.posterImage.image = UIImage(data: posterData)
        } else {
            self.posterImage.image = nil
        }
        
        self.setFavoriteImage()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.toggleFavorite))
        self.favoriteImage.addGestureRecognizer(tap)
    }
    
    @objc private func toggleFavorite() {
        guard let movie = self.movieObject else {
            return
        }
        
        if !movie.isFavorite {
            movie.addToFavorites()
        } else {
            movie.removeFromFavorites()
        }
    }
    
    func onFavoriteUpdate() {
        self.setFavoriteImage()
    }
    
    func setFavoriteImage() {
        guard let movie = self.movieObject else {
            return
        }
        
        if movie.isFavorite {
            self.favoriteImage.image = UIImage(named: "FavoriteFilled")
        } else {
            self.favoriteImage.image = UIImage(named: "FavoriteGray")
        }
    }
}
