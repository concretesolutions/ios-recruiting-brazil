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
    
    private lazy var collectionViewManager = MoviesCollectionViewManager(with: presenter)
    private lazy var presenter: MoviesListPresenterProtocol = MoviesListPresenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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
}

//MARK: - ViewProtocol methods -
extension MoviesListViewController: MoviesListViewProtocol {
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
}
