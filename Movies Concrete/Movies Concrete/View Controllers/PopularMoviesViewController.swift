//
//  ViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 28/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

protocol PopularMoviesViewControllerDelegate: class {
  func addFavorite(movie: Movie)
  func removeFavorite(movie: Movie)
}

class PopularMoviesViewController: TMViewController {
  
  //  MARK: Members
  
  var currentPage: Int!
  var total_page: Int!
  var moviesList = [Movie]()
  var filteredData = [Movie]()
  var genreList = [Genre]()
  var favorites = [Movie]()
  var request = MoviesServices()
  let coverPath = API.API_PATH_MOVIES_IMAGE
  
  weak var delegate: PopularMoviesViewControllerDelegate?
  private let popularMoviesPresenter = PopularPresenter()
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  //  MARK: Lifecycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    collectionView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    collectionView.reloadData()
  }
  
  //  MARK: Functions
  
  func setupView() {
    
    self.popularMoviesPresenter.attachView(self)
    self.popularMoviesPresenter.setupPopularMovies(data: self, collectionView: collectionView, page: 1)
    
    searchBar.delegate = self
    let data = moviesList
    filteredData = data
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.reloadData()
    collectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil),
                            forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
  }
}

// Extensions

/*
 * Collection View
 */

extension PopularMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredData.count
    }
    return moviesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for: indexPath) as! PopularMoviesCollectionViewCell
    
    let movie: Movie
    
    if isFiltering() {
      movie = filteredData[indexPath.row]
    } else {
      movie = moviesList[indexPath.row]
    }
    
    if SessionHelper.isFavorite(id: movie.id) {
      cell.favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
    } else {
      cell.favoriteAction.setImage(UIImage(named: "heart_empty"), for: .normal)
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
        self.popularMoviesPresenter.setupPopularMovies(data: self, collectionView: collectionView, page: nextPage)
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
    
    self.navigationController?.pushViewController(movieDetailViewController, animated: true)
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
extension PopularMoviesViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filteredData = moviesList.filter({( movie : Movie) -> Bool in
      return movie.title!.lowercased().contains(searchText.lowercased())
    })
    
    if isFiltering() {
      if filteredData.count == 0 {
        showErrorMessage(text: "Sorry, result not found")
      } else {
        hideErrorMessage()
      }
    } else {
      hideErrorMessage()
    }
    collectionView.reloadData()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    return !searchBarIsEmpty()
  }
  
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.text = ""
    searchBar.resignFirstResponder()
    collectionView.reloadData()
    hideErrorMessage()
  }
}

/*
 * Protocol
 */

extension PopularMoviesViewController: PopularProtocol {
  func startLoading(message: String) {
    showHud(message)
  }
  
  func stopLoading() {
    hideHud()
  }
  
  func showError(with message: String) {
    showErrorMessage(text: message)
  }
  
}

/*
 * Delegate
 */
extension PopularMoviesViewController: PopularMoviesViewControllerDelegate {
  func addFavorite(movie: Movie) {
//    if SessionHelper.isFavorite(id: movie.id) {
      SessionHelper.addFavoriteMovie(movie: movie)
//    }
  }
  
  func removeFavorite(movie: Movie) {
    SessionHelper.removeFavoriteMovie(id: movie.id)
  }
}
