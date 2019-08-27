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
  func didTapInfo()
  func showRepoDetail(url: String)
}

class MovieDetailViewController: UIViewController {
  
  // MARK: Members
  
  var name = ""
  var date = ""
  var plot = ""
  var url = ""
  var type: [Int]!
  var genreList = [Genre]()
  var movieGenre = [String]()
  var request = MoviesServices()
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
    
    getGenre()
    fillDetails()
    
  }
  
  // MARK: Functions
  
  func getGenre() {
    movieGenre = GenreMapper.getGenreData(genresId: type)
  }

  func fillDetails() {
    titleMovie.text = name
    yearMovie.text = date
    overview.text = plot
    genre.text = movieGenre.joined(separator: ", ")
    
    if let urlCover = URL(string: url) {
      cover.kf.setImage(with: urlCover)
    }
  }
  
  //  MARK: Actions
  
  @IBAction func addFavorite(_ sender: Any) {
    if favoriteAction.isSelected {
      favoriteAction.setImage(UIImage(named: "heart_empty"), for: .normal)
      favoriteAction.isSelected = false
    } else {
      favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
      favoriteAction.isSelected = true
    }
  }
  
  @IBAction func backButton(_ sender: Any) {
    self.dismiss(animated: false, completion: nil)
  }
}
