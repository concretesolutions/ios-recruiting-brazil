//
//  ViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 29/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UISearchResultsUpdating {
  
  private var favoritesMovies = [Movie]()
  private var filteredMovies = [Movie]()
  private var ids = DefaultsMovie.shared.getAll()
  private var searchText = ""
  private var searchReleaseDate = "2018"
  private var searchReleaseGenres = 0
  private var isFiltering = false
  let searchController = UISearchController(searchResultsController: nil)
  
  lazy var tableView: UITableView = {
    let table = UITableView()
    table.dataSource = self
    table.delegate = self
    table.tableFooterView = UIView(frame: .zero)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(FavoritesCell.self, forCellReuseIdentifier: "favoritesCell")
    return table
  }()
  lazy var filterButton: UIBarButtonItem = {
    let button = UIBarButtonItem(image: #imageLiteral(resourceName: "FilterIcon.png").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(tapFilterButton))
    return button
  }()
  
  var loadIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.startAnimating()
    indicator.color = .black
    return indicator
  }()
  
  private var errorMessage: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .center
    label.sizeToFit()
    return label
  }()
  
  private var errorImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  lazy private var errorButton: UIButton = {
    let button = UIButton()
    button.isHidden = true
    button.backgroundColor = .purple
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.layer.borderWidth = 0.5
    button.layer.cornerRadius = 6
    button.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
    return button
  }()
  
  lazy private var errorStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.isHidden = true
    stack.backgroundColor = .blue
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  func updateSearchResults(for searchController: UISearchController) {
    isFiltering = (searchController.searchBar.text?.isEmpty)! ? false : true
    
    filteredMovies =  favoritesMovies.filter { (movie) -> Bool in
      if movie.title.range(of: searchController.searchBar.text!) != nil {
        return true
      }
      return false
    }
    if !searchReleaseDate.isEmpty {
      filteredMovies =  filteredMovies.filter { (movie) -> Bool in
        if movie.release_date.range(of: searchReleaseDate) != nil {
          return true
        }
        return false
      }
    }
    if searchReleaseGenres != 0 {
      filteredMovies = filteredMovies.filter { (movie) -> Bool in return (movie.genre_ids!.contains(searchReleaseGenres))}
    }
    
    
    if searchText != searchController.searchBar.text! {
      tableView.reloadData()
      if favoritesMovies.isEmpty {
        getError(error: .noData)
      }else if isFiltering && filteredMovies.count == 0{
        getError(error: .empty)
      } else {
        getError(error: .noError)
      }
    }
    searchText = searchController.searchBar.text!
  }
  
  func getFavoritesMovies() {
    ids = DefaultsMovie.shared.getAll()
    loadIndicator.startAnimating()
    loadIndicator.isHidden = false
    favoritesMovies.removeAll()
    if ids.isEmpty {
      getError(error: .noData)
      tableView.reloadData()
      loadIndicator.isHidden = true
      loadIndicator.stopAnimating()
    }
    for id in ids {
      Network.shared.requestMovieById(id: id) { (result) in
        self.loadIndicator.stopAnimating()
        self.loadIndicator.isHidden = true
        switch result {
        case .success(let movie):
          self.favoritesMovies.append(movie!)
          self.getError(error: .noError)
          if self.ids.count == self.favoritesMovies.count{
            self.tableView.reloadData()
          }
        case .failure(let error):
          print("error: \(error.localizedDescription)")
          self.getError(error: .unexpected)
        }
      }
    }
  }
  
  override func loadView() {
    self.view = ContainerView(frame: UIScreen.main.bounds)
    setupNavigation()
    setupView()
  }
  
  @objc func tapFilterButton() {
    let controller = FilterTypesViewController()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  func setupNavigation() {
    navigationController?.navigationBar.tintColor = .black
    navigationItem.searchController = searchController
    navigationController?.navigationBar.barTintColor = UIColor.mango
    navigationItem.searchController?.searchResultsUpdater = self
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.searchController?.dimsBackgroundDuringPresentation = false
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
  func setupView() {
    addViews()
    getFavoritesMovies()
  }
  
  func addViews() {
    view.addSubview(tableView)
    view.addSubview(loadIndicator)
    tableView.addSubview(errorStackView)
    errorStackView.addArrangedSubview(errorImage)
    errorStackView.addArrangedSubview(errorMessage)
    tableView.addSubview(errorButton)
    navigationItem.rightBarButtonItem = filterButton
    addConstraints()
  }
  
  func addConstraints() {
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    loadIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
    loadIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
    
    errorStackView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 100).isActive = true
    errorStackView.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 15).isActive = true
    errorStackView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    errorStackView.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: -15).isActive = true
    
    errorImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

    errorButton.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    errorButton.topAnchor.constraint(equalTo: errorStackView.bottomAnchor, constant: 20).isActive = true
    errorButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    errorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getFavoritesMovies()
  }
  
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredMovies.count : favoritesMovies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let movies = isFiltering ? filteredMovies : favoritesMovies
    let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell") as! FavoritesCell

    cell.configureCell(movie: movies[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let cell = tableView.cellForRow(at: indexPath) as! FavoritesCell
    
    let deleteAction = UIContextualAction(style: .destructive, title: "descurtir") { (action, view, completion) in
      DefaultsMovie.shared.deleteId(cell.movie.id)
      self.ids = DefaultsMovie.shared.getAll()
      self.getFavoritesMovies()
      
    }
    let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
    return configuration
  }
  
  
}

extension FavoritesViewController {
  func getError(error: TypeError) {
    errorButton.removeTarget(nil, action: nil, for: .allEvents)
    switch error {
    case .empty:
      errorMessage.text = "Sua busca por \"\(searchController.searchBar.text!)\" não trouxe nenhum resultado"
      errorStackView.isHidden = false
      errorImage.image = #imageLiteral(resourceName: "search_icon.png")
    case .unexpected:
      errorMessage.text = "Ocorreu um erro. Por favor, tente novamente mais tarde."
      errorImage.image = #imageLiteral(resourceName: "ErrorIcon.png")
      errorStackView.isHidden = false
      errorButton.isHidden = false
      errorButton.setTitle("Tentar Novamente", for: .normal)
      errorButton.addTarget(self, action: #selector(tapErrorButton), for: .touchUpInside)
    case .noError:
      errorStackView.isHidden = true
      errorButton.isHidden = true
    case .noData:
      errorStackView.isHidden = false
      errorButton.isHidden = false
      errorImage.isHidden = true
      errorMessage.text = "Você ainda não curtiu nada?😱 \nVai dar uma boa olhada nos nossos filmes!"
      errorButton.setTitle("ir para a lista", for: .normal)
      errorButton.addTarget(self, action: #selector(setTabBarIndexSelected(index:)), for: .touchUpInside)
      
      
    }
  }
  @objc private func setTabBarIndexSelected(index: Int){
    tabBarController?.selectedIndex = 0
  }
  
  @objc private func tapErrorButton() {
    getFavoritesMovies()
  }

}

