//
//  MoviesCollectionCollectionViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MoviesCollectionCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, Alerts {

    // MARK: - Properties
    
    private let reuseIdentifier = "movcell"
    private let itemsPerRow: CGFloat = 2
    private let numOfSects = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
    private var shouldShowLoadingCell = false
    private var viewModel: MoviesViewModel?
    public var reloadMovies: Bool = true
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.collectionViewLayout = MoviesListFlowLayout()
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel = MoviesViewModel(delegate: self)
        setUpLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let viewModelCount = viewModel?.currentCount, viewModelCount < 1 {
            viewModel?.fetchPopularMovies()
        } else if reloadMovies {
            viewModel?.fetchPopularMovies()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navTopItem = navigationController?.navigationBar.topItem {
            navTopItem.titleView = .none
            navTopItem.title = "Movies"
        }
    }
    
    deinit {
        guard viewModel != nil else {
            return
        }
        viewModel = nil
    }
    
    // MARK: - Class Functions
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let soma = (indexPath.section * 2) + 3
        guard let viewModelCount = viewModel?.currentCount else {
            return false
        }
        return soma >= viewModelCount
    }
    
    private func setUpLoading() {
        view.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
    }
    
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let numOfMovs = viewModel?.currentCount else { return 0 }
        if (numOfMovs > 0) {
            if (numOfMovs % 2 == 0) {
                return (numOfMovs / 2)
            } else{
                return ((numOfMovs + 1) / 2)
            }
        }else {
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModelCount = viewModel?.currentCount else { return 0 }
        if viewModelCount > 0 {
            return 2
        }else{
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        guard let collectionViewModel = viewModel else {
            cell.setCell(with: .none)
            return cell
        }
        if collectionViewModel.currentCount > 0 {
            var cellIndex: Int = 0
            if (indexPath.row == 0) {
                cellIndex = (indexPath.section * 2)
            } else{
                cellIndex = ((indexPath.section * 2) + 1)
            }
            cell.setCell(with: collectionViewModel.movie(at: cellIndex))
        } else {
            cell.setCell(with: .none)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: (widthPerItem * 1.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cellIndex: Int = 0
        if (indexPath.row == 0) {
            cellIndex = (indexPath.section * 2)
        } else{
            cellIndex = ((indexPath.section * 2) + 1)
        }
        let movieToPresent = viewModel?.movie(at: cellIndex)
        let detailViewController = MovieDetailViewController()
        detailViewController.movieToPresent = movieToPresent
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - MoviesViewModelDelegate

extension MoviesCollectionCollectionViewController: MoviesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.collectionView.reloadData()
            self.reloadMovies = false
        }
    }
    
    func onFetchFailed(with reason: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: "Alerta" , message: reason, actions: [action])
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension MoviesCollectionCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel?.fetchPopularMovies()
        }
    }
    
}
