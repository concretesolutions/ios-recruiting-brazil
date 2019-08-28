//
//  MovieDetailViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieDetailViewControllerDelegate: class {
  func addFavorite(movie: Movie)
  func removeFavorite(movie: Movie)
}

class MovieDetailViewController: UIViewController {
  
  // MARK: Members
 
  var movie: Movie!
  var type: [Int]!
  var genreList = [Genre]()
  var movieGenre = [String]()
  var request = MoviesServices()
  let coverPath = API.API_PATH_MOVIES_IMAGE
  
  weak var delegate: MovieDetailViewControllerDelegate?
  
  @IBOutlet weak var cover: UIImageView!
  @IBOutlet weak var titleMovie: UILabel!
  @IBOutlet weak var yearMovie: UILabel!
  @IBOutlet weak var overview: UILabel!
  @IBOutlet weak var genre: UILabel!
  @IBOutlet weak var favoriteAction: UIButton!
  
  //  MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleMovie.text = movie.title
    overview.text = movie.overview
    
    type = movie.genreList
    movieGenre = GenreMapper.getGenreData(genresId: type)
    genre.text = movieGenre.joined(separator: ", ")
    
    let year = movie.releaseDate!
    yearMovie.text = String(year.prefix(4))
    
    let coverUrl = movie.posterPath
    let fullUrl = coverPath + coverUrl!
    if let urlCover = URL(string: fullUrl) {
      cover.kf.setImage(with: urlCover)
    }
  }
  
  
  //  MARK: Actions
  
  @IBAction func addFavorite(_ sender: Any) {
    if favoriteAction.isSelected {
      favoriteAction.setImage(UIImage(named: "heart_empty"), for: .normal)
      favoriteAction.isSelected = false
      self.delegate?.removeFavorite(movie: movie)
    } else {
      favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
      favoriteAction.isSelected = true
      self.delegate?.addFavorite(movie: movie)
    }
  }
  
  @IBAction func backButton(_ sender: Any) {
    self.dismiss(animated: false, completion: nil)
  }
}

/*
 * Delegates
 */
extension MovieDetailViewController: MovieDetailViewControllerDelegate {
  func addFavorite(movie: Movie) {
    FavoriteMovie.shared.addFavorite(movie: movie)
    print("add favorite")
  }
  
  func removeFavorite(movie: Movie) {
    //    print("removeu")
    //    print(SessionHelper.getFavorites())
  }
}
