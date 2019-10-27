//
//  MoviesViewController.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 24/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

extension MoviesViewController {
    enum ScreenStatus {
        case normal
        case loading
        case empty
        case error
    }
}

class MoviesViewController: UIViewController {
    
    // MARK: - Constants
    let reuseIdentifier = "MovieCollectionViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Variables
    var moviesList: MovieListResponse?
    var viewModel: MoviesViewControllerViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configMovieCollectionView()
        viewModel = MoviesViewControllerViewModel(delegate: self)
        viewModel.requestPopularMovies(page: 1)
    }
    
    private func configView() {
        navigationItem.searchController?.searchResultsUpdater = self
    }
    
    private func configMovieCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let cellMargin: CGFloat = 8.0
        layout.sectionInset = UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
        movieCollectionView.setCollectionViewLayout(layout, animated: true)
        
        let cellNib = UINib(nibName: reuseIdentifier, bundle: nil)
        movieCollectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
}

// MARK: - MoviesViewControllerProtocol
extension MoviesViewController: MoviesViewControllerProtocol {
    func changeScreenStatus(type: ScreenStatus) {
        switch type {
        case .normal:
            movieCollectionView.isHidden = false
            activityIndicatorView.stopAnimating()
            emptyView.isHidden = true
            errorView.isHidden = true
        case .loading:
            movieCollectionView.isHidden = true
            activityIndicatorView.startAnimating()
            emptyView.isHidden = true
            errorView.isHidden = true
        case .empty:
            movieCollectionView.isHidden = true
            activityIndicatorView.stopAnimating()
            emptyView.isHidden = false
            errorView.isHidden = true
        case .error:
            movieCollectionView.isHidden = true
            activityIndicatorView.stopAnimating()
            emptyView.isHidden = true
            errorView.isHidden = false
        }
    }
    
    func setMoviesList(movies: MovieListResponse) {
        moviesList = movies
        movieCollectionView.reloadData()
    }
    
    func setError(message: String) {
        errorLabel.text = message
    }
}

// MARK: - SearchController
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

// MARK: - MovieCollectionView
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 2
        let cellWidth = (UIScreen.main.bounds.size.width / numberOfCell) - 14
        return CGSize(width: cellWidth, height: cellWidth * 1.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        if let movie = moviesList?.results?[indexPath.row] {
            cell.configureCell(with: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = DetailsViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}
