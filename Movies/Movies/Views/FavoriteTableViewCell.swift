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
  
  @IBOutlet weak var genresActivityIndicatorView: UIActivityIndicatorView!
  @IBOutlet weak var posterDownloadActivityIndicatorView: UIActivityIndicatorView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  var movie: Movie!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    posterImageView.clipsToBounds = true
    posterImageView.layer.cornerRadius = 10
    posterImageView.layer.borderColor = UIColor.paleGrey.cgColor
    posterImageView.layer.borderWidth = 1
  }
  
  enum PosterDownloadState {
    case loading
    case loaded
  }
  
  enum GenreLoadingState {
    case loading
    case loaded
  }
  
  var currentPosterDownloadState: PosterDownloadState! {
    didSet {
      switch currentPosterDownloadState! {
      case .loaded:
        posterDownloadActivityIndicatorView.stopAnimating()
        posterDownloadActivityIndicatorView.isHidden = true
      case .loading:
        posterDownloadActivityIndicatorView.startAnimating()
        posterDownloadActivityIndicatorView.isHidden = false
      }
    }
  }
  
  var currentGenreLoadingState: GenreLoadingState! {
    didSet {
      switch currentGenreLoadingState! {
      case .loaded:
        genresActivityIndicatorView.stopAnimating()
        genresActivityIndicatorView.isHidden = true
      case .loading:
        genresActivityIndicatorView.startAnimating()
        genresActivityIndicatorView.isHidden = false
      }
    }
  }
  
  func configure(withMovie movie: Movie) {
    self.movie = movie
    
    currentPosterDownloadState = .loading
    posterImageView.sd_setImage(with: NetworkClient.shared.getImageDownloadURL(fromPath: movie.posterPath)) { (_, _, _, _) in
      self.currentPosterDownloadState = .loaded
    }
    
    currentGenreLoadingState = .loading
    NetworkClient.shared.getGenres { (result) in
      switch result {
      case .success(let genres):
        self.genresLabel.text = self.getGenresName(fromGenresArray: genres).joined(separator: ", ")
        self.currentGenreLoadingState = .loaded
      case .failure:
        print("error")
      }
    }
    
    titleLabel.text = movie.title
    overviewLabel.text = movie.overview
    yearLabel.text = "\(Calendar.current.component(.year, from: movie.releaseDate))"
  }
  
  func getGenresName(fromGenresArray genres: [Genre]) -> [String] {
    let genresName = movie.genresID.map { (currentId) -> String in
      let filteredGenres = genres.filter {$0.identificator == currentId}
      return filteredGenres[0].name
    }
    
    return genresName
  }
  
}
