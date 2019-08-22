//
//  MoviesCollectionViewCell.swift
//  Movs
//
//  Created by Marcos Lacerda on 10/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit
import Kingfisher

protocol MoviesActionDelegate {
  func handlerFavorite(_ movie: Movies, isFaved: Bool, callback: @escaping ((Bool) -> Void))
  func notifyActionError(_ error: String)
}

class MoviesCollectionViewCell: UICollectionViewCell {

  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var moviePoster: UIImageView!
  @IBOutlet weak fileprivate var movieName: UILabel!
  @IBOutlet weak fileprivate var movieFaved: UIButton!
  
  fileprivate let placeholder = #imageLiteral(resourceName: "movie-placeholder")
  fileprivate let globalSettings = MovsSingleton.shared.globalSettings!
  fileprivate var movie: Movies!
  
  var delegate: MoviesActionDelegate!
  
  // MARK: - Setup
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    moviePoster.image = placeholder
    movieName.text = ""
    movieFaved.isSelected = false
  }
  
  func setup(with movie: Movies) {
    self.movie = movie

    movieName.text = movie.title
    movieFaved.isSelected = movie.faved

    // Loading the movie poster
    let path = movie.poster
    let baseURL = globalSettings.imageURL
    let preferredSize = globalSettings.avaliablePosterSizes.last!
    let fullURL = String(format: "%@%@%@", baseURL, preferredSize, path)

    guard let url = URL(string: fullURL) else { return }

    moviePoster.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.1))])
  }
  
  // MARK: - Actions
  
  @IBAction fileprivate func favedClick(_ sender: UIButton) {
    let isFaved = sender.isSelected

    delegate.handlerFavorite(movie, isFaved: isFaved) { [weak self] success in
      if !success {
        self?.delegate.notifyActionError("faved-action-error".localized())
        return
      }

      self?.handlerFavorite(sender)
    }
  }
  
  fileprivate func handlerFavorite(_ sender: UIButton) {
    UIView.transition(with: sender, duration: 0.8, options: .transitionCrossDissolve, animations: {
      sender.isSelected = !sender.isSelected
    }, completion: nil)
  }

}
