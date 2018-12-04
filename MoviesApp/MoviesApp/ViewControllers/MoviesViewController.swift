//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    fileprivate lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var movies: [Movie] = []
    fileprivate var searchMovies: [Movie] = []
    fileprivate let presenter = MoviesPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.atttach(self)
        self.setupSearchController()
        self.setupCollectionView()
        self.navigationController?.navigationBar.tintColor = UIColor.moviesAppBlack
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard (searchController.searchBar.text ?? "").isEmpty else {
            return
        }
        presenter.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard (searchController.searchBar.text ?? "").isEmpty else {
            return
        }
        let nMovies = movies.count
        let nCells = moviesCollectionView.numberOfItems(inSection: 0)
        if nMovies > nCells {
            var nearbyIndexes: [IndexPath] = []
            for i in nCells...(nMovies - 1) {
                nearbyIndexes.append(IndexPath(row: movies.count + i, section: 0))
            }
            moviesCollectionView.insertItems(at: nearbyIndexes)
        } else if nMovies < nCells {
            moviesCollectionView.reloadData()
        }
    }

    @IBAction func retryTapped(_ sender: Any) {
        self.searchController.searchBar.text = ""
        presenter.loadData()
    }
}

//MARK: - Setup Methods
fileprivate extension MoviesViewController {
    func setupSearchController() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        self.searchController.searchBar.barStyle = .black
        self.searchController.searchBar.tintColor = UIColor.moviesAppBlack
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    func setupCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 12.0
        flowLayout.sectionInset = UIEdgeInsets(top: 12.0,
                                               left: 12.0,
                                               bottom: 12.0,
                                               right: 12.0)
        self.moviesCollectionView.collectionViewLayout = flowLayout
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MovieCollectionViewCell.nib,
                                      forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
}

//MARK: - UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchMovies = []
        } else {
            searchMovies = movies.filter({ (movie) -> Bool in
                movie.title.contains(searchText)
            })
        }
        moviesCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchMovies = []
        moviesCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate - UICollectionViewDataSource - UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if !(searchController.searchBar.text ?? "").isEmpty {
            return searchMovies.count
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! MovieCollectionViewCell
        if !(searchController.searchBar.text ?? "").isEmpty {
            cell.set(searchMovies[indexPath.row])
        } else {
            cell.set(movies[indexPath.row])
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - 36.0)/2.0
        return CGSize(width: cellWidth, height: 1.25*cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard (searchController.searchBar.text ?? "").isEmpty else {
            return
        }
        if indexPath.row == movies.count - 1 && !activityIndicator.isAnimating && !UIApplication.shared.isNetworkActivityIndicatorVisible {
            self.presenter.loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie!
        if !(searchController.searchBar.text ?? "").isEmpty {
            movie = searchMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        self.navigationController?.pushViewController(MovieDetailPresenter.initView(with: movie), animated: true)
    }
}

//MARK: - MovieCollectionViewCellDelegateProtocol
extension MoviesViewController: MovieCollectionViewCellDelegateProtocol {
    func favoriteTapped(at cell: MovieCollectionViewCell) {
        if cell.favoriteButton.isSelected {
            presenter.favorite(movie: movies[self.moviesCollectionView.indexPath(for: cell)!.row])
        } else {
            presenter.unfavorite(movie: movies[self.moviesCollectionView.indexPath(for: cell)!.row])
        }
    }
}

//MARK: - MoviesViewProtocol
extension MoviesViewController: MoviesViewProtocol {
    func startNewPageLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func endNewPageLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func add(page: [Movie]) {
        if page.count > 0 {
            var nearbyIndexes: [IndexPath] = []
            for i in 0...(page.count - 1) {
                nearbyIndexes.append(IndexPath(row: movies.count + i, section: 0))
            }
            movies.append(contentsOf: page)
            moviesCollectionView.insertItems(at: nearbyIndexes)
        }
    }
    
    func startLoading() {
        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func endLoading() {
        self.view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    func set(movies: [Movie]) {
        self.movies = movies
        self.moviesCollectionView.reloadData()
    }
    
    func show(error: Error) {
        self.errorView.isHidden = false
    }
}
