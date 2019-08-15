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
  
  // MARK: - Private properties
  
  fileprivate var state: ViewState = .normal {
    didSet {
//      self.setupView()
    }
  }
  
  fileprivate var viewModel: MoviesViewModel!
  fileprivate var datasource: MoviesDatasource = MoviesDatasource()
  
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    DispatchQueue.main.async { [weak self] in
      self?.loadMovies()
    }
  }
  
  // MARK: - Private methods
  
  fileprivate func customizeNavigationBar() {
    self.title = "movies-title".localized()

    self.configureTitleNavigationBar(#colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1))
    self.configureNavigationBar(tintColor: #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1), barColor: #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1))
    self.configureSearchField(in: searchBar, with: #colorLiteral(red: 0.8509803922, green: 0.5921568627, blue: 0.1176470588, alpha: 1), and: #colorLiteral(red: 0.4862745098, green: 0.4745098039, blue: 0.4745098039, alpha: 1))
  }
  
  fileprivate func loadMovies() {
    self.state = .loading
    viewModel.fetchMovies()
  }
  
  fileprivate func setupView() {
    switch state {
    case .loading: self.activityIndicator.startAnimating()
    default: self.activityIndicator.stopAnimating()
    }
  }
  
  fileprivate func configureCollectionView() {
    collectionView.dataSource = datasource

    collectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
  }
  
  // MARK: - Interactions

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }

  // MARK: - Actions
  
}

extension MoviesViewController: MoviesViewModelDelegate {
  
  func loadMoviesSuccess() {
    collectionView.reloadData()
  }
  
  func loadMoviesError(_ error: String) {
    self.state = .error
    
    self.showErrorMessage(error, tryAgainCallback: { [weak self] in
      self?.loadMovies()
    })
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
    }

    return true
  }
  
}

extension MoviesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movieDetailViewModel = viewModel.makeMovieDetail(at: indexPath)
    let movieDetailController = MovieDetailViewController(with: movieDetailViewModel)

    self.navigationController?.pushViewController(movieDetailController, animated: true)
  }
  
}


extension MoviesViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 166, height: 205)
  }
  
}
