//
//  FavoritesViewCell.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    
    @IBOutlet weak var poster: KFImageView!
    @IBOutlet weak var favoriteIcon: UIButton!
    
    var movie: Movie? {
        didSet {
            
            guard let movie = self.movie else { return }
            if let url = movie.posterURL {
                self.poster.setImage(with: url, frame: self.frame)
            } else {
                // placeholder
            }
            
            
            if let favorite = try? CoreDataService.shared.isFavorite(movie.id) {
                if favorite {
                    self.favoriteIcon.setImage(UIImage(named: "favorite"), for: .normal)
                } else {
                    self.favoriteIcon.setImage(UIImage(named: "notFavorite"), for: .normal)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        self.favoriteIcon.addTarget(self, action: #selector(self.favorite), for: .touchUpInside)
        super.layoutSubviews()
    }
    
    @objc func favorite() {
        guard let movie = self.movie else { return }
        if movie.favorite {
            
            try? CoreDataService.shared.delete(movie.id)
            self.favoriteIcon.setImage(UIImage(named: "notFavorite"), for: .normal)

        } else {
            
            _ = try? CoreDataService.shared.insertFavorite(movie.id)
            self.favoriteIcon.setImage(UIImage(named: "favorite"), for: .normal)
            
        }
        
        self.movie?.favorite = !movie.favorite
    }
    
}
