//
//  PopularMoviesCollectionViewCell.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imgMovie: UIImageView!
  @IBOutlet weak var titleMovie: UILabel!
  @IBOutlet weak var favoriteAction: UIButton!
  
  var movie: Movie!
  weak var delegate : PopularMoviesViewControllerDelegate!
  
  @IBAction func addFavorite(_ sender: Any) {
    if favoriteAction.isSelected {
      favoriteAction.setImage(UIImage(named: "heart_empty"), for: .normal)
      favoriteAction.isSelected = false
      self.delegate?.removeFavorite(movie: movie)
    } else {
      favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
      favoriteAction.isSelected = true
      self.delegate?.addFavorite(movie: movie)
    }
  }
}
