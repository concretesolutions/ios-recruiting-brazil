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
  @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
  
  enum CellLoadingState {
    case loading
    case loaded
  }
  
  enum CellFavoriteState {
    case favorite
    case notFavorite
  }
  
  var currentLoadingState: CellLoadingState! {
    didSet {
      switch currentLoadingState! {
      case .loaded:
        loadingActivityIndicatorView.isHidden = true
      case .loading:
        loadingActivityIndicatorView.isHidden = false
      }
    }
  }
  
  var currentFavoriteState: CellFavoriteState! {
    didSet {
      switch currentFavoriteState! {
      case .favorite:
        starContainerView.alpha = 1
        starImageView.image = UIImage(named: "star_selected")
      case .notFavorite:
        starContainerView.alpha = 0.6
        starImageView.image = UIImage(named: "star")
      }
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  
    posterImageView.clipsToBounds = true
    posterImageView.layer.cornerRadius = 10
    posterImageView.layer.borderColor = UIColor(red: 216 / 255.0, green: 216 / 255.0, blue: 216 / 255.0, alpha: 1).cgColor
    posterImageView.layer.borderWidth = 1

    let path = UIBezierPath(roundedRect: starContainerView.bounds, byRoundingCorners: [.bottomLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    starContainerView.layer.mask = mask
    
    starContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteButtonTapped)))
  }
  
  func configure(withMovie movie: Movie) {
    titleLabel.text = movie.title
    ratingLabel.text = String(format: "Rating: %.1f/10", movie.voteAverage)
    yearLabel.text = "\(Calendar.current.component(.year, from: movie.releaseDate))"
    currentFavoriteState = movie.isFavorite ? .favorite : .notFavorite
    currentLoadingState = .loading
    posterImageView.sd_setImage(with: NetworkClient().getImageDownloadURL(fromPath: movie.posterPath)) { (_, _, _, _) in
      self.currentLoadingState = .loaded
    }
  }
  
  @objc func favoriteButtonTapped() {
    if currentFavoriteState == .favorite {
      currentFavoriteState = .notFavorite
    } else {
      currentFavoriteState = .favorite
    }
  }
}
