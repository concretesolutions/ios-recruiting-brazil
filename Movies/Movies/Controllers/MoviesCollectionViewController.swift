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
  
  var isUpdating = false
  
  enum ViewState {
    case loading
    case success
    case error(String)
  }
  
  var currentViewState: ViewState! {
    didSet {
      switch currentViewState! {
      case .error(let errorMessage):
        errorView.isHidden = false
        loadingView.isHidden = true
        print(errorMessage)
      case .success:
        errorView.isHidden = true
        loadingView.isHidden = true
      case .loading:
        loadingView.isHidden = false
        errorView.isHidden = true
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
    
    collectionView.performBatchUpdates(updates) { (_) in
      self.isUpdating = false
    }
  }
  
  fileprivate func setupCollectionView() {
    moviesDelegate = MoviesCollectionViewDelegate(frameWidth: view.frame.width, delegate: self)
    moviesDataSource = MoviesDataSource(posterHeight: moviesDelegate.newPosterHeight)
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
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = false
    
    setupCollectionView()
    
    setupSubviews()
    
    fetchMovies()
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
    return !moviesDataSource.movies.isEmpty
  }
}
