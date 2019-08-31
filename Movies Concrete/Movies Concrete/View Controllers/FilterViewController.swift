//
//  FilterViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 28/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

class FilterViewController: TMViewController {
  
  //  MARK: Members
  
  let request = MoviesServices()
  var data = MovieDetailViewController()
  var genre: [(Int, String)] = []
  var filter: [Int] = []
  var index = 0
  
  private let filterPresenter = FilterPresenter()
  
  @IBOutlet weak var tableView: UITableView!
  
  //  MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Filter"
    self.navigationController?.navigationBar.tintColor = UIColor.white
    
    self.filterPresenter.attachView(self)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    setupGenres()
 
  }
  
  //  MARK: Functions
  
  func setupGenres() {
    self.filterPresenter.getGenresMovies()
    let genres = SessionHelper.getGenres()
    for i in genres {
      genre.append((Int(i.id), String(i.name)))
    }
  }
  
  func selectFilter() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addFilter))
  }
  
  @objc func addFilter() {
    let favoriteViewController = storyboard?.instantiateViewController(withIdentifier: "FavoritesMoviesViewController") as? FavoritesMoviesViewController
    favoriteViewController?.title = "Favorites Filtered"
    favoriteViewController?.moviesFilter = filter
    favoriteViewController?.isFilterOn = true
    self.navigationController?.pushViewController(favoriteViewController!, animated: true)
    
  }
  
  func deselectFilter() {
    self.navigationItem.rightBarButtonItem = nil
  }
}

// MARK: Extensions

/*
 * Table View
 */

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return genre.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")
    cell?.textLabel?.text = genre[indexPath.row].1
    cell?.textLabel?.textColor = Colors.colorWhite
  
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.black
    cell?.selectedBackgroundView = backgroundView
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")
    filter.append(genre[indexPath.row].0)
    selectFilter()
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") {
      for (index, filteredMovie) in filter.enumerated() {
        if genre[indexPath.row].0 == filteredMovie {
          filter.remove(at: index)
        }
      }
      if filter.count == 0 {
        deselectFilter()
      }
    }
  }
}

/*
 * Protocol
 */
extension FilterViewController: FilterProtocol {
  func showError(with message: String) {
    showErrorMessage(text: message)
  }
}
