//
//  MovieDetailViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: TMViewController {
  
  // MARK: Members
  
  var movie: Movie!
  var type: [Int]!
  var genres = [Genre]()
  var genreList = [Genre]()
  var movieGenre = [String]()
  var request = MoviesServices()
  let coverPath = API.API_PATH_MOVIES_IMAGE
  
  private let movieDetailPresenter = DetailPresenter()
  
  @IBOutlet weak var cover: UIImageView!
  @IBOutlet weak var titleMovie: UILabel!
  @IBOutlet weak var yearMovie: UILabel!
  @IBOutlet weak var overview: UILabel!
  @IBOutlet weak var genre: UILabel!
  @IBOutlet weak var favoriteAction: UIButton!
  
  //  MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Detail"
    self.navigationController?.navigationBar.tintColor = UIColor.white
    
    self.movieDetailPresenter.attachView(self)
    
    fillDetails()
  }
  
  //  MARK: Functions
  
  func mapGenres() -> [String] {
    var genresName = [String]()
    self.movieDetailPresenter.getGenresMovies()
    genres = SessionHelper.getGenres()
    
    for genres in genres {
      for id in type {
        if id == genres.id {
          genresName.append(genres.name!)
        }
      }
    }
    return genresName
  }
  
  func fillDetails() {
    
    titleMovie.text = movie.title
    overview.text = movie.overview
    
    type = movie.genreList
    movieGenre = mapGenres()
    genre.text = movieGenre.joined(separator: ", ")
    
    if SessionHelper.isFavorite(id: movie.id) {
      favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
    } else {
      favoriteAction.setImage(UIImage(named: "heart_empty"), for: .normal)
    }
    
    let year = movie.releaseDate!
    yearMovie.text = String(year.prefix(4))
    
    let coverUrl = movie.posterPath
    let fullUrl = coverPath + coverUrl!
    if let urlCover = URL(string: fullUrl) {
      cover.kf.setImage(with: urlCover)
    }
  }
  
  //  MARK: Actions
  
  @IBAction func favoriteAction(_ sender: Any) {
    if favoriteAction.isSelected {
      favoriteAction.setImage(UIImage(named: "heart_empty"), for: .normal)
      favoriteAction.isSelected = false
      //      SessionHelper.removeFavoriteMovie(id: movie.id)
    } else {
      favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
      favoriteAction.isSelected = true
      if SessionHelper.isFavorite(id: movie.id) {
        showAlert(title: "Atention", message: "Movie already added to favorite", action: "OK")
      } else {
        SessionHelper.addFavoriteMovie(movie: movie)
      }
    }
  }
}

// MARK: Extensions

/*
 * Protocol
 */

extension MovieDetailViewController: DetailProtocol {
  func showError(with message: String) {
    showErrorMessage(text: message)
  }
  
}
