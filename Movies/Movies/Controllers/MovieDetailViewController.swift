//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 01/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
  
  var movie: Movie!
  
  @IBOutlet weak var backdropheightConstraint: NSLayoutConstraint!
  @IBOutlet weak var gradientView: UIView!
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var backdropInfoView: UIView!
  @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
  @IBOutlet weak var genreLoadingActivityIndicatorView: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  enum ViewState {
    case loading
    case loaded
  }
  
  enum FavoriteState {
    case favorite
    case notFavorite
  }
  
  enum GenreLoadingState {
    case loading
    case loaded
  }
  
  var currentViewState: ViewState! {
    didSet {
      switch currentViewState! {
      case .loading:
        loadingActivityIndicatorView.isHidden = false
        loadingActivityIndicatorView.startAnimating()
        backdropInfoView.isHidden = true
        gradientView.isHidden = true
      case .loaded:
        loadingActivityIndicatorView.isHidden = true
        loadingActivityIndicatorView.stopAnimating()
        backdropInfoView.isHidden = false
        gradientView.isHidden = false
      }
    }
  }
  
  var currentFavoriteState: FavoriteState! {
    didSet {
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
      imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleFavorite)))
      
      switch currentFavoriteState! {
      case .favorite:
        imageView.image = AssetsManager.getImage(forAsset: .starSelected)
      case .notFavorite:
       imageView.image = AssetsManager.getImage(forAsset: .starBordered)
      }
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
    }
  }
  
  var currentGenreLoadingState: GenreLoadingState! {
    didSet {
      switch currentGenreLoadingState! {
      case .loaded:
        genreLoadingActivityIndicatorView.stopAnimating()
        genreLoadingActivityIndicatorView.isHidden = true
        genresLabel.isHidden = false
      case .loading:
        genreLoadingActivityIndicatorView.startAnimating()
        genreLoadingActivityIndicatorView.isHidden = false
        genresLabel.isHidden = true
      }
    }
  }
  
  @objc func toggleFavorite() {
    if currentFavoriteState == .favorite {
      currentFavoriteState = .notFavorite
      LocalStorage.shared.removeFavorite(movie: movie)
    } else {
      currentFavoriteState = .favorite
      LocalStorage.shared.addFavorite(movie: movie)
    }
  }
  
  func configureView() {
    setupGradientView()
    
    backdropInfoView.isHidden = true
    currentFavoriteState = movie.isFavorite ? .favorite : .notFavorite
    
    title = movie.title
    
    backdropheightConstraint.constant = view.frame.width * 281.0 / 500.0
    
    currentViewState = .loading
    
    if movie.backdropPath.isEmpty {
      backdropImageView.image = AssetsManager.getImage(forAsset: .movieBackdropPlaceholder)
      currentViewState = .loaded
    } else {
      backdropImageView.sd_setImage(with: NetworkClient.shared.getImageDownloadURL(fromPath: movie.backdropPath)) { (_, _, _, _) in
        self.currentViewState = .loaded
      }
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
    
    ratingLabel.text = String(format: "Rating: %.1f/10", movie.voteAverage)
    yearLabel.text = "\(Calendar.current.component(.year, from: movie.releaseDate))"
    overviewLabel.text = movie.overview
  }

  func setupGradientView() {
    let topColor = UIColor.black.withAlphaComponent(0.0)
    let bottomColor = UIColor.black
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = gradientView.bounds
    gradientView.layer.addSublayer(gradientLayer)
  }
  
  func getGenresName(fromGenresArray genres: [Genre]) -> [String] {
    let genresName = movie.genresID.map { (currentId) -> String in
      let filteredGenres = genres.filter {$0.identificator == currentId}
      return filteredGenres[0].name
    }
    
    return genresName
  }
}
