//
//  MovieCollectionViewCell.swift
//  
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 30/10/18.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var posterHeightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func layoutSubviews() {
    posterImageView.clipsToBounds = true
    posterImageView.layer.cornerRadius = 10
  }
}
