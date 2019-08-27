//
//  FavoritesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 21/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

//protocol FavoritesViewControllerDelegate: class {
//  func didTapBack()
//}

class FavoritesViewController: UIViewController {
  
  // MARK: Members
  
  var favorites : [Movie] = []
  
  let coverPath = API.API_PATH_MOVIES_IMAGE
  @IBOutlet weak var favoritesTableView: UITableView!
  //  weak var delegate: FavoritesViewControllerDelegate?
  
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    favoritesTableView.separatorStyle = .none
    favoritesTableView.dataSource = self
    favoritesTableView.delegate = self
    
    favoritesTableView.register(UINib(nibName: "FavoriteMoviesTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "FavoriteMoviesTableViewCell")
    
    favoritesTableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "EmptyTableViewCell")
    
  }
  
}


// MARK: Extensions

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate  {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
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
    //    articlesTableView.deselectRow(at: indexPath, animated: true)
  }
  
}


