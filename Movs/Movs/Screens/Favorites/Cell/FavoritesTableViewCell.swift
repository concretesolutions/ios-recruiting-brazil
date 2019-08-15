//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Marcos Lacerda on 11/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var moviePoster: UIImageView!
  @IBOutlet weak fileprivate var movieName: UILabel!
  @IBOutlet weak fileprivate var movieYear: UILabel!
  @IBOutlet weak fileprivate var movieSinopse: UILabel!
  
  fileprivate let placeholder = #imageLiteral(resourceName: "movie-placeholder")
  fileprivate let globalSettings = MovsSingleton.shared.globalSettings!
  
  // MARK: - Setup
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    moviePoster.image = placeholder
    movieName.text = ""
    movieYear.text = ""
    movieSinopse.text = ""
  }
  
  func setup(with movie: Movies) {
    movieName.text = movie.title
    movieYear.text = movie.releaseAt.toDate().format(with: "yyyy")
    movieSinopse.text = movie.overview
    
    // Loading the movie poster
    let path = movie.poster
    let baseURL = globalSettings.imageURL
    let preferredSize = globalSettings.avaliablePosterSizes.last!
    let fullURL = String(format: "%@%@%@", baseURL, preferredSize, path)
    
    guard let url = URL(string: fullURL) else { return }
    
    moviePoster.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.1))])
  }

}
