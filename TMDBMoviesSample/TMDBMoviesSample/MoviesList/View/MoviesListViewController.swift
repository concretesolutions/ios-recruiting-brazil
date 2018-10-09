//
//  MoviesListViewController.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var refreshIcon: UIImageView!
    @IBOutlet private weak var searchBarContainer: UIView!
    @IBOutlet private weak var searchBarHeight: NSLayoutConstraint!
    @IBOutlet private weak var emptySearchLabel: UILabel!
    
    private lazy var collectionViewManager = MoviesCollectionViewManager(with: presenter, collectionView)
    private lazy var presenter: MoviesListPresenterProtocol = MoviesListPresenter(with: self)
    
    var errorIsShowing: Bool {
        return !errorView.isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupRetryButton()
        presenter.getMovies()
    }
}

//MARK: - SetupMethods -
extension MoviesListViewController {
    private func setupCollectionView() {
        collectionView.delegate = collectionViewManager
        collectionView.dataSource = collectionViewManager
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(cellType: MovieCell.self)
    }
    
    private func setupRetryButton() {
        refreshIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshAction)))
    }
    
    @objc private func refreshAction() {
        presenter.getMovies()
    }
    
    func setSearchBar() {
        let searchController = collectionViewManager.searchController
        searchController.searchResultsUpdater = collectionViewManager
        searchController.delegate = collectionViewManager
        searchController.searchBar.delegate = collectionViewManager
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Digite o nome do filme"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .minimal
        searchBarHeight.constant = searchController.searchBar.frame.height
        searchBarContainer.addSubview(searchController.searchBar)
    }
}

//MARK: - ViewProtocol methods -
extension MoviesListViewController: MoviesListViewProtocol {
    func setupSearchBar() {
        DispatchQueue.main.async {
            self.setSearchBar()
        }
    }
    
    func addSection(in index: Int) {
        DispatchQueue.main.async {
            self.collectionView.insertSections(IndexSet(integer: index))
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
        }
    }
    
    func hideCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
        }
    }
    
    func showErrorView() {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
        }
    }
    
    func hideErrorView() {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
        }
    }
    
    func showErrorLoading() {
        DispatchQueue.main.async {
            self.refreshIcon.rotate360Degrees(duration: 1)
        }
    }
    
    func hideErrorLoading() {
        DispatchQueue.main.async {
            self.refreshIcon.layer.removeAllAnimations()
        }
    }
    
    func showEmptySearchLabel() {
        DispatchQueue.main.async {
            self.emptySearchLabel.isHidden = false
        }
    }
    
    func hideEmptySearchLabel() {
        DispatchQueue.main.async {
            self.emptySearchLabel.isHidden = true
        }
    }
    
    func show(with vc: UIViewController) {
        navigationController?.show(vc, sender: nil)
    }
}
