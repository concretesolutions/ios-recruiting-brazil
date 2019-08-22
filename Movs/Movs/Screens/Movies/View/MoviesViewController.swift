//
//  MoviesViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class MoviesViewController: BaseViewController {

  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak fileprivate var searchBar: UISearchBar!
  @IBOutlet weak fileprivate var collectionView: UICollectionView!
  @IBOutlet weak fileprivate var searchEmptyView: UIView!
  @IBOutlet weak fileprivate var searchEmptyLabel: UILabel!
  
  // MARK: - Private properties
  
  fileprivate var state: ViewState = .normal {
    didSet {
      self.setupView()
    }
  }
  
  fileprivate var viewModel: MoviesViewModel!
  fileprivate var datasource: MoviesDatasource = MoviesDatasource()
  fileprivate let refreshControl = UIRefreshControl()
  
  // MARK: - Initializers
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    viewModel = MoviesViewModel(with: self, datasource: datasource)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    viewModel = MoviesViewModel(with: self, datasource: datasource)
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.customizeNavigationBar()
    self.configureCollectionView()
    self.configureEmptyView()
    self.configureRefreshControl()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    DispatchQueue.main.async { [weak self] in
      self?.loadMovies()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.searchBar.endEditing(true)
  }
  
  // MARK: - Private methods
  
  fileprivate func customizeNavigationBar() {
    self.title = "movies-title".localized()

    self.configureTitleNavigationBar(#colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1))
    self.configureNavigationBar(tintColor: #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1), barColor: #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1))
    self.configureSearchField(in: searchBar, with: #colorLiteral(red: 0.8509803922, green: 0.5921568627, blue: 0.1176470588, alpha: 1), and: #colorLiteral(red: 0.4862745098, green: 0.4745098039, blue: 0.4745098039, alpha: 1))
  }
  
  fileprivate func configureEmptyView() {
    searchEmptyLabel.text = "empty-search-label".localized()
  }
  
  fileprivate func loadMovies() {
    self.state = .loading
    viewModel.fetchMovies()
  }
  
  fileprivate func setupView() {
    switch state {
    case .loading:
      self.searchEmptyView.isHidden = true
      self.collectionView.isHidden = true
      self.activityIndicator.startAnimating()

    case .normal:
      self.refreshControl.endRefreshing()
      self.activityIndicator.stopAnimating()
      self.searchEmptyView.isHidden = true
      self.collectionView.isHidden = false
      
    case .searching(let hasResult): self.endSearch(hasResult: hasResult)
    
    default: self.activityIndicator.stopAnimating()
    }
  }
  
  fileprivate func configureCollectionView() {
    datasource.delegate = self
    
    collectionView.refreshControl = refreshControl
    collectionView.dataSource = datasource

    collectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
  }
  
  fileprivate func configureRefreshControl() {
    refreshControl.tintColor = #colorLiteral(red: 1, green: 0.6898958683, blue: 0, alpha: 1)
    refreshControl.addTarget(self, action: #selector(loadFirstPage), for: .valueChanged)
  }
  
  // MARK: - Interactions

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }

  // MARK: - Actions
  
  @objc fileprivate func loadFirstPage() {
    viewModel.fetchMovies()
  }
  
  fileprivate func endSearch(hasResult: Bool) {
    searchEmptyView.isHidden = hasResult
  }
  
  fileprivate func performSearch(_ term: String) {
    viewModel.search(with: term)
  }
  
}

extension MoviesViewController: MoviesViewModelDelegate {
  
  func loadMoviesSuccess() {
    self.state = .normal
    collectionView.reloadData()
  }
  
  func loadMoviesError(_ error: String) {
    self.state = .error
    
    self.showErrorMessage(error, tryAgainCallback: { [weak self] in
      self?.loadMovies()
    })
  }
  
  func searchWithResult() {
    self.state = .searching(hasResult: true)
    self.collectionView.reloadData()
  }
  
  func searchEmpty() {
    self.state = .searching(hasResult: false)
  }
  
  func clearSearch() {
    self.state = .searching(hasResult: true)
    self.collectionView.reloadData()
  }
  
}

extension MoviesViewController: UISearchBarDelegate {
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.clearOffset()
    return true
  }
  
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    if searchBar.text!.isEmpty {
      searchBar.centeredPlaceHolder()
      
      if datasource.inSearch {
        viewModel.clearSearch()
      }
    }

    return true
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text, !searchText.trim().isEmpty else {
      self.showErrorMessage("empty-search-error".localized(), withTryAgainButton: false)
      return
    }

    searchBar.endEditing(true)

    self.performSearch(searchText)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if datasource.inSearch && searchText.isEmpty {
      viewModel.clearSearch()
    }
  }
  
}

extension MoviesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movieDetailViewModel = viewModel.makeMovieDetail(at: indexPath)
    let movieDetailController = MovieDetailViewController(with: movieDetailViewModel)

    self.navigationController?.pushViewController(movieDetailController, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == datasource.movies.count - 1 {
      viewModel.nextPage()
    }
  }
  
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 166, height: 205)
  }
  
}

extension MoviesViewController: MoviesActionDelegate {
  
  func handlerFavorite(_ movie: Movies, isFaved: Bool, callback: @escaping ((Bool) -> Void)) {
    viewModel.handlerFavorite(movie, isFaved: isFaved, callback: callback)
  }
  
  func notifyActionError(_ error: String) {
    self.showErrorMessage(error, withTryAgainButton: false)
  }
  
}
