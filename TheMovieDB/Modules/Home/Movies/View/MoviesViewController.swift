//
//  MoviesViewController.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 24/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - Constants
    let reuseIdentifier = "MovieCollectionViewCell"
    let cellMargin: CGFloat = 16.0
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configMovieCollectionView()
    }
    
    private func configView() {
        navigationItem.searchController?.searchResultsUpdater = self
    }
    
    private func configMovieCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
        movieCollectionView.setCollectionViewLayout(layout, animated: true)
        
        let cellNib = UINib(nibName: reuseIdentifier, bundle: nil)
        movieCollectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 2
        let cellWidth = (UIScreen.main.bounds.size.width / numberOfCell) - (cellMargin * 1.33)
        return CGSize(width: cellWidth, height: cellWidth * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = DetailsViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}
