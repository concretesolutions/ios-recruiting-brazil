//
//  MovieCollectionViewCell.swift
//  
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 30/10/18.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var posterHeightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var starContainerView: UIView!
  @IBOutlet weak var starImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func layoutSubviews() {
    posterImageView.clipsToBounds = true
    posterImageView.layer.cornerRadius = 10
    posterImageView.layer.borderColor = UIColor(red: 216 / 255.0, green: 216 / 255.0, blue: 216 / 255.0, alpha: 1).cgColor
    posterImageView.layer.borderWidth = 1
    
    let path = UIBezierPath(roundedRect: starContainerView.bounds, byRoundingCorners: [.bottomLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    starContainerView.layer.mask = mask
    if Int.random(in: 0 ... 10) > 7 {
      starImageView.image = UIImage(named: "star_selected")
      starContainerView.alpha = 1
    }
  }
  
  func configure(movie: Movie) {
    titleLabel.text = movie.title
    ratingLabel.text = String(format: "Rating: %.1f/10", movie.voteAverage)
    yearLabel.text = "2001"
    posterImageView.sd_setImage(with: NetworkClient().getImageDownloadURL(fromPath: movie.posterPath)) { (_, _, _, _) in
      print("Image donwloaded")
    }
  }
}
