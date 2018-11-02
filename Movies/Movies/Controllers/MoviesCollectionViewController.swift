//
//  ViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {
  
  var moviesDataSource: MoviesDataSource!
  
  var moviesDelegate: MoviesCollectionViewDelegate!
  
  var loadingView: LoadingView!
  
  var errorView: ErrorView!
  
  var noResultsView: NoResultsView!
  
  var isUpdating = false
  
  var tabBarDelegate: TabBarControllerDelegate!
  
  var searchController: UISearchController!

  enum ViewState {
    case loading
    case success
    case error(String)
    case searchNotFound(String)
  }
  
  var currentViewState: ViewState! {
    didSet {
      switch currentViewState! {
      case .error(let errorMessage):
        errorView.isHidden = false
        loadingView.isHidden = true
        noResultsView.isHidden = true
        print(errorMessage)
      case .success:
        errorView.isHidden = true
        loadingView.isHidden = true
        noResultsView.isHidden = true
      case .loading:
        loadingView.isHidden = false
        errorView.isHidden = true
        noResultsView.isHidden = true
      case .searchNotFound(let searchString):
        loadingView.isHidden = true
        errorView.isHidden = true
        noResultsView.isHidden = false
        noResultsView.setSearchString(searchString)
      }
    }
  }
  
  fileprivate func fetchMovies() {
    currentViewState = .loading
    NetworkClient.shared.fetchPopularMovies { (result) in
      switch result {
      case .success(let movies):
        self.currentViewState = .success
        self.moviesDataSource.movies = movies
        self.collectionView.reloadData()
      case .failure(let error):
        self.currentViewState = .error(error.localizedDescription)
        print(error)
      }
    }
  }
  
  @objc fileprivate func fetchMoreMovies() {
    NetworkClient.shared.fetchPopularMovies { (result) in
      switch result {
      case .success(let movies):
        self.updateCollectionView(withMovies: movies)
      case .failure(let error):
        self.isUpdating = false
        print(error)
      }
    }
  }
  
  func updateCollectionView(withMovies movies: [Movie]) {
    let updates = {
      var indexes = [IndexPath]()
      
      for movie in movies {
        self.moviesDataSource.movies.append(movie)
        let lastItem = self.moviesDataSource.movies.count - 1
        let section = 0
        indexes.append(IndexPath(row: lastItem, section: section))
      }
      
      self.collectionView.insertItems(at: indexes)
    }
    
    collectionView.performBatchUpdates(updates) { _ in
      self.isUpdating = false
    }
  }
  
  fileprivate func setupCollectionView() {
    moviesDelegate = MoviesCollectionViewDelegate(frameWidth: view.frame.width, updateDelegate: self, itemSelectDelegate: self)
    moviesDataSource = MoviesDataSource(posterHeight: moviesDelegate.newPosterHeight, searchController: searchController, updateCollectionDelegate: self)
    LocalStorage.shared.delegate = moviesDataSource
    searchController.searchResultsUpdater = moviesDataSource
    self.collectionView.delegate = moviesDelegate
    self.collectionView.dataSource = moviesDataSource
    collectionView.register(cellType: MovieCollectionViewCell.self)
  }
  
  fileprivate func setupSubviews() {
    loadingView = LoadingView()
    loadingView.frame.origin = CGPoint(x: view.center.x - loadingView.frame.width / 2, y: view.center.y)
    view.addSubview(loadingView)
    
    errorView = ErrorView(tryAgainButtonHandler: fetchMovies)
    errorView.frame.origin = CGPoint(x: view.center.x - errorView.frame.width / 2, y: view.center.y - 20)
    view.addSubview(errorView)
    
    noResultsView = NoResultsView()
    noResultsView.frame.origin = CGPoint(x: view.center.x - noResultsView.frame.width / 2, y: view.center.y - 150)
    view.addSubview(noResultsView)
  }
  
  fileprivate func setupSearchController() {
    searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Movies"
    definesPresentationContext = true
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  fileprivate func loadGenres() {
    NetworkClient.shared.getGenres { (result) in
      switch result {
      case .failure(let error):
        print(error)
      case .success:
        print("Genres loaded")
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBarDelegate = TabBarControllerDelegate(delegate: self)
    tabBarController?.delegate = tabBarDelegate
    
    setupSearchController()
    
    setupCollectionView()
    
    setupSubviews()
    
    fetchMovies()
    
    loadGenres()
    
    launchScreenAnimation()

  }
  
}

extension MoviesCollectionViewController: MoviesCollectionViewUpdateDelegate {
  func loadMoreMovies() {
    if !isUpdating && !moviesDataSource.movies.isEmpty {
      isUpdating = true
      fetchMoreMovies()
    }
  }
  
  func canShowFooter() -> Bool {
    return !moviesDataSource.movies.isEmpty && !moviesDataSource.isFiltering()
  }
}

extension MoviesCollectionViewController: TabBarTapDelegate {
  func handleTapOnFirstIndex() {
    if !moviesDataSource.movies.isEmpty {
      collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
  }
}

extension MoviesCollectionViewController: UpdateCollectionDelegate {
  func updateCollection() {
    collectionView.reloadData()
  }
  
  func handleResult(hasResults: Bool, forSearchedString string: String) {
    if !hasResults {
      currentViewState = .searchNotFound(string)
    } else {
      currentViewState = .success
    }
  }
  
}

extension MoviesCollectionViewController {
  func launchScreenAnimation() {
    tabBarController?.tabBar.isHidden = true
    let superView = navigationController!.view!
    let launchScreenAnimationView = LaunchScreenAnimationView(frame: superView.frame)
    launchScreenAnimationView.animateView(onSuperView: superView) {
      self.tabBarController?.tabBar.isHidden = false
    }
  }
}

extension MoviesCollectionViewController: CollectionViewdidSelectItemDelegate {
  func didSelectIndexPath(_ indexPath: IndexPath) {
    var aMovie: Movie
    if moviesDataSource.isFiltering() {
      aMovie = moviesDataSource.filteredMovies[indexPath.row]
    } else {
      aMovie = moviesDataSource.movies[indexPath.row]
    }

    self.performSegue(withIdentifier: "movieToDetailViewSegue", sender: aMovie)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "movieToDetailViewSegue" {
      if let destinationViewController = segue.destination as? MovieDetailViewController {
        if let aMovie = sender as? Movie {
          destinationViewController.movie = aMovie
        }
      }
    }
  }
}
