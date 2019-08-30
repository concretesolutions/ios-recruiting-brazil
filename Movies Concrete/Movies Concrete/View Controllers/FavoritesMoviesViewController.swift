//
//  FavoritesMoviesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 27/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerDelegate: class {
  func removeFavorite(movie: Movie)
}

class FavoritesMoviesViewController: TMViewController {
  
  // MARK: Members
  
  var favorites: [Movie] = []
  var genres: [Genre] = []
  var moviesFilter: [Int] = []
  var genresName: [String] = []
  var filteredData: [Movie] = []
  var filteredMovies: [Movie] = []
  let request = MoviesServices()
  var isFilterOn: Bool = false
  let coverPath = API.API_PATH_MOVIES_IMAGE
  private let refreshControl = UIRefreshControl()
  
  private let favoritesPresenter = FavoritesPresenter()
  weak var delegate: FavoritesViewControllerDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  // MARK: Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupView()
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    tableView.reloadData()
  }
  
  
  // MARK: Functions
  
  func setupView() {
    self.favoritesPresenter.attachView(self)
    self.favoritesPresenter.setupGenresMovies()
    
    genres = SessionHelper.getGenres()
    
    searchBar.delegate = self
    let data = favorites
    filteredData = data
    
    if isFilterOn {
      setupFilters()
    }
    
    getFavorites()
    setupTableView()
  }
  
  func setupFilters() {
    for movie in favorites {
      if let movieGenres = movie.genreList {
        for genre in moviesFilter {
          for movieId in movieGenres {
            if genre == movieId {
              filteredMovies.append(movie)
            }
          }
        }
      }
    }
  }
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
    tableView.tableFooterView = UIView()
    
    tableView.register(UINib(nibName: "FavoriteMoviesTableViewCell", bundle: nil),
                       forCellReuseIdentifier: "FavoriteMoviesTableViewCell")
    
    if #available(iOS 10.0, *) {
      tableView.refreshControl = refreshControl
    } else {
      tableView.addSubview(refreshControl)
    }
    
    refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
  }
  
  func getFavorites() {
    favorites = SessionHelper.getFavorites()
    refreshControl.endRefreshing()
  }
  
  @objc private func refreshData(_ sender: Any) {
    if favorites.count > 0 {
      getFavorites()
      tableView.reloadData()
      refreshControl.endRefreshing()
    } else {
      refreshControl.endRefreshing()
    }
    getFavorites()
  }
}

// MARK: Extensions

/*
 * Table View
 */

extension FavoritesMoviesViewController: UITableViewDataSource, UITableViewDelegate  {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredData.count
    } else if isFilterOn {
      return filteredMovies.count
    } else {
      return favorites.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var auxCell: UITableViewCell?
    
    if favorites.count > 0  {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMoviesTableViewCell", for: indexPath) as! FavoriteMoviesTableViewCell
      
      let movie: Movie
      
      if isFiltering() {
        movie = filteredData[indexPath.row]
      } else if isFilterOn {
        movie = filteredMovies[indexPath.row]
      } else {
        movie = favorites[indexPath.row]
      }
      
      let genresId = movie.genreList
      
      for genres in genres {
        for id in genresId! {
          if id == genres.id {
            genresName.append(genres.name!)
          }
        }
      }
      
      cell.genreMovie.text = genresName.joined(separator: ", ")
      movie.genresName = genresName
      
      genresName.removeAll()
      
      cell.titleMovie.text = movie.title
      cell.plotMovie.text = movie.overview
      cell.movie = movie
      cell.delegate = self
      
      cell.favoriteAction.setImage(UIImage(named: "heart_full"), for: .normal)
      cell.favoriteAction.isSelected = true
      
      let year = movie.releaseDate!
      cell.yearMovie.text = String(year.prefix(4))
      
      let coverUrl = movie.posterPath
      let fullUrl = coverPath + coverUrl!
      if let url = URL(string: fullUrl) {
        cell.imgMovie.kf.setImage(with: url)
      }
      auxCell = cell
    }
    
    return auxCell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
    
    let movie: Movie
    
    if isFiltering() {
      movie = filteredData[indexPath.row]
    } else if isFilterOn {
      movie = filteredMovies[indexPath.row]
    } else {
      movie = favorites[indexPath.row]
    }
    
    movieDetailViewController.movie = movie
    
    self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

/*
 * Search Bar
 */

extension FavoritesMoviesViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filteredData = favorites.filter({( movie : Movie) -> Bool in
      return movie.title!.lowercased().contains(searchText.lowercased())
    })
    
    if isFiltering() {
      if filteredData.count == 0 {
        showErrorMessage(text: "Sorry, result not found in favorite")
      } else {
        hideErrorMessage()
      }
    } else {
      hideErrorMessage()
    }
    tableView.reloadData()
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
    tableView.reloadData()
    hideErrorMessage()
  }
}

/*
 * Protocol
 */

extension FavoritesMoviesViewController: FavoritesProtocol {
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

extension FavoritesMoviesViewController: FavoritesViewControllerDelegate {
  func removeFavorite(movie: Movie) {
    SessionHelper.removeFavoriteMovie(id: movie.id)
    getFavorites()
  }
}
