//
//  MoviesCollectionCollectionViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MoviesCollectionCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, Alerts {

    private let reuseIdentifier = "movcell"

    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
    private var viewModel: MoviesViewModel?
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.collectionViewLayout = MoviesListFlowLayout()
        collectionView.contentInsetAdjustmentBehavior = .always
        viewModel = MoviesViewModel(delegate: self)
        viewModel?.fetchPopularMovies()
        setUpLoading()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let itens = viewModel?.currentCount {
            return itens
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
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
    
    // MARK: Class Funcitons
    
    private func setUpLoading() {
        view.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
    }
    
    // MARK: UICollectionViewDelegate

}

// MARK: - UICollectionView MoviesViewModelDelegate

extension MoviesCollectionCollectionViewController: MoviesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
        let title = "Alerta"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}
