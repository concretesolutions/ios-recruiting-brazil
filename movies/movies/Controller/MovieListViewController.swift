//
//  MovieListViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    var viewModel: MovieListViewModel = MovieListViewModel()
    
    override func loadView() {
        let view = MovieListViewControllerScreen(frame: UIScreen.main.bounds)
        
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        
        self.view = view
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = search
        self.title = "Movies"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - Collection View Data Source
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.movieCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let cellViewModel = self.viewModel.viewModelForMovie(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = cellViewModel
        
        return cell
    }
}

// MARK: - Collection View Data Source
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 180
        return CGSize(width: width, height: width*1.5)
    }
}
