//
//  MovieViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 30/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UISearchResultsUpdating{
  
  var filteredMovies = [PopularMovie]()
  private let searchController = UISearchController(searchResultsController: nil)
  private var isFiltering = false
  private var searchTextAux = ""
  private var popularMovies = [PopularMovie]()
  lazy var collectionView: UICollectionView = {
    let flowLayout =  UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
    let collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
    collection.backgroundColor = .white
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.dataSource = self
    collection.delegate = self
    collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "movieCell")
    
    return collection
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
  
  override func loadView() {
    self.view = ContainerView(frame: UIScreen.main.bounds)
    setupNavigation()
    setupView()
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    isFiltering = (searchController.searchBar.text?.isEmpty)! ? false : true

    filteredMovies =  popularMovies.filter { (movie) -> Bool in
      if movie.title.range(of: searchController.searchBar.text!) != nil {
        return true
      }
      return false
    }
    if searchTextAux != searchController.searchBar.text! {
      collectionView.reloadData()
      if isFiltering && filteredMovies.count == 0{
        getError(error: .empty)
      } else {
        getError(error: .noError)
      }
    }
    searchTextAux = searchController.searchBar.text!
    
  }
  
  func getMovies() {
    self.loadIndicator.startAnimating()
    self.loadIndicator.isHidden = false
    Network.shared.requestPopularMovies { (result) in
      self.loadIndicator.stopAnimating()
      self.loadIndicator.isHidden = true
      switch result {
      case .failure(let error):
        print("error: \(error.localizedDescription)")
        self.getError(error: .unexpected)
      case .success(let page):
        self.popularMovies = (page?.results)!
        self.collectionView.reloadData()
        self.getError(error: .noError)
      }
    }
  }
  
  private func setupNavigation() {
    searchController.searchBar.placeholder = "Pesquisa"
    navigationItem.searchController = searchController
    navigationController?.navigationBar.barTintColor = UIColor.mango
    navigationItem.searchController?.searchResultsUpdater = self
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.searchController?.dimsBackgroundDuringPresentation = false
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
    
  }
  
  func setupView() {
    addviews()
    getMovies()
  }
  
  func addviews() {
    view.addSubview(collectionView)
    view.addSubview(loadIndicator)
    collectionView.addSubview(errorStackView)
    errorStackView.addArrangedSubview(errorImage)
    errorStackView.addArrangedSubview(errorMessage)
    collectionView.addSubview(errorButton)
    addConstraints()
  }
  
  func addConstraints() {
    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    loadIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
    loadIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
    
    errorStackView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100).isActive = true
    errorStackView.leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: 15).isActive = true
    errorStackView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    errorStackView.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: -15).isActive = true

    errorImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    errorButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
   // errorButton.leftAnchor.constraint(lessThanOrEqualTo: collectionView.leftAnchor, constant: 15).isActive = true
    errorButton.topAnchor.constraint(equalTo: errorStackView.bottomAnchor, constant: 20).isActive = true
   // errorButton.rightAnchor.constraint(lessThanOrEqualTo: collectionView.rightAnchor, constant: -15).isActive = true
    errorButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    errorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    
  }

}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return isFiltering ? filteredMovies.count : popularMovies.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let movies = isFiltering ? filteredMovies : popularMovies
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionCell
//    cell.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    cell.backgroundColor = .black
    cell.configureCell(movie: movies[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 190)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailsController = DetailsViewController()
    let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionCell
    detailsController.movie = cell.movie
    detailsController.poster = cell.posterImage.image!
    navigationController?.pushViewController(detailsController, animated: true)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    navigationItem.searchController?.searchBar.endEditing(true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    collectionView.reloadData()
  }
  
}


// Mark:  Tratamento do fluxo de erros
extension MovieViewController {
  private func emptySeach() {
    errorMessage.text = "Sua busca por \"\(searchController.searchBar.text!)\" não trouxe nenhum resultado"
    errorStackView.isHidden = false
    errorImage.image = #imageLiteral(resourceName: "search_icon.png")
  }
  
  private func unexpectedError() {
    errorMessage.text = "Ocorreu um erro. Por favor, tente novamente mais tarde."
    errorImage.image = #imageLiteral(resourceName: "ErrorIcon.png")
    errorStackView.isHidden = false
    errorButton.isHidden = false
    errorButton.setTitle("Tentar Novamente", for: .normal)
    errorButton.addTarget(self, action: #selector(tapErrorButton), for: .touchUpInside)
  }
  
  func getError(error: TypeError) {
    switch error {
    case .empty:
      emptySeach()
    case .unexpected:
      unexpectedError()
    case .noError:
      errorStackView.isHidden = true
      errorButton.isHidden = true
      
    }
  }
  
  @objc private func tapErrorButton() {
    print("estou funcionando")
    getMovies()
  }
}


enum TypeError {
  case empty
  case unexpected
  case noError
}
