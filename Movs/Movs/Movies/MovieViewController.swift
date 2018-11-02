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
  
  override func loadView() {
    self.view = ContainerView(frame: UIScreen.main.bounds)
    setupNavigation()
    setupCollection()
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
    }
    searchTextAux = searchController.searchBar.text!
    
  }
  
  func setupCollection() {
    view.addSubview(collectionView)
    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    getMovies()
  }
  
  private func setupNavigation() {
    searchController.searchBar.placeholder = "Pesquisa"
    navigationItem.searchController = searchController
    navigationController?.navigationBar.barTintColor = UIColor.mango
    navigationItem.searchController?.searchResultsUpdater = self
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.searchController?.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    
  }
  
  @objc func test() {
    
  }
  func getMovies() {
    Network.shared.requestPopularMovies { (result) in
      switch result {
      case .failure(let error):
        print("error: \(error.localizedDescription)")
      case .success(let page):
        self.popularMovies = (page?.results)!
        self.collectionView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    navigationItem.searchController?.searchBar.endEditing(true)
  }
  
}
