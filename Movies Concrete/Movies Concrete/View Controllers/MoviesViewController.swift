//
//  MoviesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 21/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: Delegate

protocol MoviesViewControllerDelegate: class {
  func addFavorite(movie: Movie)
}

class MoviesViewController: TMViewController {
  
  // MARK: Members
  
  var currentPage: Int!
  var total_page: Int!
  var moviesList = [Movie]()
  var genreList = [Genre]()
  var favorites : [Movie] = []
  var request = MoviesServices()
  let coverPath = API.API_PATH_MOVIES_IMAGE
  weak var delegate: MoviesViewControllerDelegate?
  
  @IBOutlet weak var popularCollectionView: UICollectionView!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getPopularMoviesList()
    
    popularCollectionView.dataSource = self
    popularCollectionView.delegate = self
    popularCollectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil),
                                   forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
  }
  
  // MARK: Functions
  
  func getPopularMoviesList() {
    self.showHud("Loading")
    if NetworkState.isConnected() {
       request.getPopularMovies(data: self, collectionView: popularCollectionView, page: 1)
      self.hideHud()
    } else {
      self.hideHud()
      self.showAlert(title: "Atention", message: "Verify the internet conection", action: "OK")
    }
  }
}

// MARK: Extensions

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return moviesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for: indexPath) as! PopularMoviesCollectionViewCell
    
    let movie = moviesList[indexPath.row]
    cell.titleMovie.text = movie.title
    cell.delegate = self
    cell.movie = movie
    
    let coverUrl = movie.posterPath
    let fullUrl = coverPath + coverUrl!
    if let url = URL(string: fullUrl) {
      cell.imgMovie.kf.setImage(with: url)
    }
    
    let lastItem = moviesList.count - 1
    if indexPath.row == lastItem {
      if total_page > 1 && currentPage <= total_page {
        let nextPage = currentPage + 1
        request.getPopularMovies(data: self, collectionView: popularCollectionView, page: nextPage)
        currentPage = nextPage
      }
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
    
    let movie = moviesList[indexPath.row]
    movieDetailViewController.name = movie.title!
    movieDetailViewController.plot = movie.overview!
    movieDetailViewController.type = movie.genreList
    
    let year = movie.releaseDate!
    movieDetailViewController.date = String(year.prefix(4))
    
    let coverUrl = movie.posterPath
    let fullUrl = coverPath + coverUrl!
    movieDetailViewController.url = fullUrl
    
    self.present(movieDetailViewController, animated: true, completion: nil)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let padding: CGFloat =  50
    let collectionViewSize = collectionView.frame.size.width - padding
    
    return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
  }
  
}

extension MoviesViewController: MoviesViewControllerDelegate {
  func addFavorite(movie: Movie) {
    print("bateu aqui")
    self.showAlert(title: "Atention", message: "Clicou aqui", action: "OK")
//    var favorites : [Movie] = []
//    //    var favoritesDefaults = UserDefaults.standard.object(forKey: "favorites")
//    favorites.append(movie)
//    UserDefaults.standard.set(favorites, forKey: "favorites")
    //    favoritesDefaults.synchronize()
    
  }
  
  
}
