//
//  FavoriteTableViewCell.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 02/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit
import Reusable

class FavoriteTableViewCell: UITableViewCell, NibReusable {
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    posterImageView.clipsToBounds = true
    posterImageView.layer.cornerRadius = 10
    posterImageView.layer.borderColor = UIColor.paleGrey.cgColor
    posterImageView.layer.borderWidth = 1
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
