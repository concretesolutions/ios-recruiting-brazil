//
//  ViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 29/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class Favorites: UIViewController, UISearchResultsUpdating {
  
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.dataSource = self
    table.tableFooterView = UIView(frame: .zero)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(FavoritesCell.self, forCellReuseIdentifier: "favoritesCell")
    return table
  }()
  private var ids = DefaultsMovie.shared.getAll()
  func updateSearchResults(for searchController: UISearchController) {
    
  }
  
  override func loadView() {
    self.view = ContainerView(frame: UIScreen.main.bounds)
    setupNavigation()
    setupView()
  }
  
  func setupNavigation() {
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
    navigationController?.navigationBar.barTintColor = UIColor.mango
    navigationItem.searchController?.searchResultsUpdater = self
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.searchController?.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
  }
  
  func setupView() {
    addViews()
  }
  
  func addViews() {
    view.addSubview(tableView)
    addConstraints()
  }
  
  func addConstraints() {
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
}

extension Favorites: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ids.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell") as! FavoritesCell
    cell.configureCell(id: ids[indexPath.row])
    return cell
  }
  
  
}

