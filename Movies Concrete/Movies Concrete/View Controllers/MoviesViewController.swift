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
  func removeFavorite(movie: Movie)
}

class MoviesViewController: TMViewController {

  // MARK: Members
  
  var currentPage: Int!
  var total_page: Int!
  var moviesList = [Movie]()
  var filteredData = [Movie]()
  var genreList = [Genre]()
  var favorites = [Movie]()
  var request = MoviesServices()
  let coverPath = API.API_PATH_MOVIES_IMAGE
  
  weak var delegate: MoviesViewControllerDelegate?
  
  var isFavorite = false
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var popularCollectionView: UICollectionView!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    self.navigationItem.title = "Movies"
    
    getPopularMoviesList()
    
    favorites = FavoriteMovie.shared.getFavorites()
    
    searchBar.delegate = self
    let data = moviesList
    filteredData = data

    popularCollectionView.dataSource = self
    popularCollectionView.delegate = self
    popularCollectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil),
                                   forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
  }
  
  // MARK: Functions
  
  @objc func buttonClicked(sender: UIButton) {
    print("clicou tb")
    if sender.isSelected {
      sender.setImage(UIImage(named: "heart_empty"), for: .normal)
    } else {
      sender.setImage(UIImage(named: "heart_full"), for: .normal)
    }
  }
  
 
  /*
   * Request API
   */
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

/*
 * Collection View
 */
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredData.count
    }
    return moviesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for: indexPath) as! PopularMoviesCollectionViewCell
    
    let movie: Movie
    
    if isFiltering() {
      movie = filteredData[indexPath.row]
    } else {
      movie = moviesList[indexPath.row]
    }
  
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
    
    let movie: Movie
    
    if isFiltering() {
      movie = filteredData[indexPath.row]
    } else {
      movie = moviesList[indexPath.row]
    }
    
    movieDetailViewController.movie = movie
    
    self.present(movieDetailViewController, animated: true, completion: nil)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let padding: CGFloat =  50
    let collectionViewSize = collectionView.frame.size.width - padding
    
    return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
  }
  
}

/*
 * Search Bar
 */
extension MoviesViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filteredData = moviesList.filter({( movie : Movie) -> Bool in
      return movie.title!.lowercased().contains(searchText.lowercased())
    })
    popularCollectionView.reloadData()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    return !searchBarIsEmpty()
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.searchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.text = ""
    searchBar.resignFirstResponder()
    popularCollectionView.reloadData()
  }
  
}

/*
 * Delegates
 */
extension MoviesViewController: MoviesViewControllerDelegate {
  
  func addFavorite(movie: Movie) {
    FavoriteMovie.shared.addFavorite(movie: movie)
    print("add favorite")
  }

  func removeFavorite(movie: Movie) {
//    print("removeu")
    //    print(SessionHelper.getFavorites())
  }
  
}
