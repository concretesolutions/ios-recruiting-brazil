//
//  FavoritesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 21/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit


class FavoritesViewController: UIViewController {
  
  // MARK: Members
  
  var favorites : [Movie] = []
  private let refreshControl = UIRefreshControl()
  let coverPath = API.API_PATH_MOVIES_IMAGE
  
  @IBOutlet weak var favoritesTableView: UITableView!
  //  weak var delegate: FavoritesViewControllerDelegate?
  
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getFavorites()

    favoritesTableView.dataSource = self
    favoritesTableView.delegate = self
    favoritesTableView.reloadData()
    favoritesTableView.tableFooterView = UIView()
    
    
    favoritesTableView.register(UINib(nibName: "FavoriteMoviesTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "FavoriteMoviesTableViewCell")
    
    favoritesTableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "EmptyTableViewCell")
    
    // Add Refresh Control to Table View
    if #available(iOS 10.0, *) {
      favoritesTableView.refreshControl = refreshControl
    } else {
      favoritesTableView.addSubview(refreshControl)
    }
    
    // Configure Refresh Control
    refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
    
  }
  
  // MARK: Functions
  
  func getFavorites() {
    favorites = FavoriteMovie.shared.getFavorites()
//    self.refreshControl.endRefreshing()
  }
  
  @objc private func refreshData(_ sender: Any) {
//    favorites = [Movie]()
    if favorites.count > 0 {
      getFavorites()
      self.favoritesTableView.reloadData()
      self.refreshControl.endRefreshing()
    } else {
      self.refreshControl.endRefreshing()
    }
    getFavorites()
  }
  
}


// MARK: Extensions

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate  {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var auxCell: UITableViewCell?
    
    if favorites.count == 0 {
      let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath)
      auxCell = cell
    } else {
      let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteMoviesTableViewCell", for: indexPath) as! FavoriteMoviesTableViewCell
      
      let movie = favorites[indexPath.row]
      cell.titleMovie.text = movie.title
      cell.plotMovie.text = movie.overview
      
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
    
    //    if isFiltering() {
    //      movie = filteredData[indexPath.row]
    //    } else {
    movie = favorites[indexPath.row]
    //    }
    
    movieDetailViewController.movie = movie
    
    self.present(movieDetailViewController, animated: true, completion: nil)
    
    favoritesTableView.deselectRow(at: indexPath, animated: true)
  }
  
}


