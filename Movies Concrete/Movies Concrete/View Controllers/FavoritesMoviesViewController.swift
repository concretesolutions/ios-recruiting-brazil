//
//  FavoritesMoviesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 27/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

class FavoritesMoviesViewController: UIViewController {
  
  lazy var searchBar: UISearchBar = UISearchBar()
  
  //  MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSearchBar()
    
    self.navigationItem.title = "Favorites"
    self.view.backgroundColor = Colors.colorBackground
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    
  }
  
  //  MARK: Functions
  
  func setupSearchBar() {
    searchBar.searchBarStyle = UISearchBar.Style.minimal
    searchBar.placeholder = " Search a favorite movie"
    searchBar.sizeToFit()
    searchBar.backgroundColor = Colors.colorDetail
    searchBar.isTranslucent = true
    view.addSubview(searchBar)
    
    // setup constraints
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
    searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
    searchBar.topAnchor.constraint(equalTo:self.topLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
    //      searchBar.delegate = self
    //      navigationItem.titleView = searchBar
  }
  
  
//  @objc func pushToNextVC() {
//    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "teste")
//
//    //      viewController.modalPresentationStyle = .fullScreen
//    //      self.present(viewController, animated: true, completion: nil)
//
//    self.navigationController?.pushViewController(viewController, animated: true)
//
//  }
  
}

//extension PopularMoviesViewController: UISearchBarDelegate {
//  
//}
