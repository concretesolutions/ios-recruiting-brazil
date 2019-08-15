//
//  MovieDetailTableViewCell.swift
//  Movs
//
//  Created by Marcos Lacerda on 14/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var coverImageView: UIImageView!
  @IBOutlet weak fileprivate var movieNameLabel: UILabel!
  @IBOutlet weak fileprivate var favedButton: UIButton!
  @IBOutlet weak fileprivate var movieYearLabel: UILabel!
  @IBOutlet weak fileprivate var movieGenresLabel: UILabel!
  @IBOutlet weak fileprivate var movieDescriptionLabel: UILabel!
  
  fileprivate let placeholder = #imageLiteral(resourceName: "movie-placeholder")
  fileprivate let globalSettings = MovsSingleton.shared.globalSettings!
  
  // MARK: - Lifecycle
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    coverImageView.image = placeholder
    movieNameLabel.text = ""
    favedButton.isSelected = false
    movieYearLabel.text = ""
    movieGenresLabel.text = ""
    movieDescriptionLabel.text = ""
  }
  
  // MARK: - Setup
  
  func setup(with movie: Movies) {
    movieNameLabel.text = movie.title
    favedButton.isSelected = movie.faved
    movieYearLabel.text = movie.releaseAt.toDate().format(with: "yyyy")
    movieGenresLabel.text = movie.genresList
    movieDescriptionLabel.text = movie.overview
    
    // Loading the movie poster
    let path = movie.cover
    let baseURL = globalSettings.imageURL
    let preferredSize = globalSettings.avaliablePosterSizes.last!
    let fullURL = String(format: "%@%@%@", baseURL, preferredSize, path)
    guard let url = URL(string: fullURL) else { return }
    
    coverImageView.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.1))])
  }
  
  // MARK: - Actions
  
  @IBAction fileprivate func favedClick(_ sender: UIButton) {
    UIView.transition(with: sender, duration: 0.8, options: .transitionCrossDissolve, animations: {
      sender.isSelected = !sender.isSelected
    }, completion: nil)
  }
  
}
