//
//  MovieCollectionViewController.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    var presenter: MoviePresenter?
    
    private var collectionViewDataSource: MovieCollectionViewDataSource?
    
    private var estimatedCellWidth: CGFloat = Constants.MovieCollectionView.estimatedCellWidth
    private var cellMargin: CGFloat = Constants.MovieCollectionView.cellMargin
    
    var fetchingMoreMovies: Bool = false
        
    var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: Constants.MovieCollectionView.cellMargin,
                                           left: 7,
                                           bottom: Constants.MovieCollectionView.cellMargin,
                                           right: 7)
        layout.minimumLineSpacing = Constants.MovieCollectionView.cellMargin
        layout.minimumInteritemSpacing = Constants.MovieCollectionView.cellMargin
        layout.estimatedItemSize = CGSize(width: Constants.MovieCollectionView.estimatedCellWidth,
                                          height: Constants.MovieCollectionView.estimatedCellHeight + 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MovieCollectionView.cellId)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    var errorView: ErrorView = {
        let errorView = ErrorView(errorImageName: Constants.ErrorValues.popularImageName, errorText: Constants.ErrorValues.popularMoviesText)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    init(presenter: MoviePresenter) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Movies"
        self.presenter = presenter
        self.collectionViewDataSource = MovieCollectionViewDataSource(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        // MARK: - Loads Movies Data
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.loadCollectionView(page: 1)
         }
        setupUI()
        movieCollectionView.dataSource = collectionViewDataSource
        movieCollectionView.delegate = self
    }
    
    // MARK: - Setup UI
    func setupUI() {
        self.view.addSubview(movieCollectionView)
        setupConstraints()
    }
    // MARK: - Setup Constraints
    func setupConstraints() {
        
        // MARK: - Collection View Constraints
        movieCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupErrorContraints() {
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - Collection View Delegate
extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieDetails(movie: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height {
            if !self.fetchingMoreMovies {
                self.presenter?.getMoreMovies()
            }
        }
    }
}

// MARK: - Movie View Delegate
extension MovieViewController: MovieViewDelegate {
    
    func showError(imageName: String, text: String) {
        self.view.addSubview(errorView)
        errorView.errorText = text
        errorView.errorImageName = imageName
        errorView.setupUI()
        errorView.setupConstraints()
        setupErrorContraints()
    }
    
    func removeError() {
        errorView.removeFromSuperview()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.movieCollectionView.reloadData()
            self.fetchingMoreMovies = false
        }
    }
}
