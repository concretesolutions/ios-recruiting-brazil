//
//  FavoriteMoviesTableViewCell.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

class FavoriteMoviesTableViewCell: UITableViewCell {
  
  // MARK: Members
  
  @IBOutlet weak var imgMovie: UIImageView!
  @IBOutlet weak var titleMovie: UILabel!
  @IBOutlet weak var plotMovie: UILabel!
  @IBOutlet weak var yearMovie: UILabel!
  @IBOutlet weak var favoriteAction: UIButton!
  
  
  @IBAction func addFavorite(_ sender: Any) {
    if favoriteAction.isSelected {
      favoriteAction.setImage(UIImage(named: "heart_empty"), for: .normal)
      favoriteAction.isSelected = false
    } else {
      favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
      favoriteAction.isSelected = true
    }
  }
  
}
