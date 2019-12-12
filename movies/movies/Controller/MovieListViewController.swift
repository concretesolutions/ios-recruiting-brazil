//
//  MovieListViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

class MovieListViewController: UIViewController {
    var viewModel: MovieListViewModel = MovieListViewModel()
    var screen: MovieListViewControllerScreen!
        
    override func loadView() {
        screen = MovieListViewControllerScreen(frame: UIScreen.main.bounds, state: viewModel.$state.eraseToAnyPublisher())
        screen.collectionView.dataSource = self
        screen.collectionView.delegate = self
        
        self.view = screen
        
        self.setupNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.viewModel.$movieCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.perform(#selector(self?.loadCollectionView), with: nil, afterDelay: 1.0)
            }
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        self.navigationItem.searchController = SearchController() // Set custom search controller as navigation item search
        
        if let searchController = self.navigationItem.searchController as? SearchController {
            self.viewModel.bindQuery(searchController.publisher) // Use search controller as query publisher
        }
    }
    
    @objc func loadCollectionView() {
        self.screen.collectionView.reloadData()
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
        
        cell.setViewModel(cellViewModel)
        
        return cell
    }
}

// MARK: - Collection View Data Source
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        // Let collection view with two cells when in portrait mode and with four in landscape mode
        let width: CGFloat = self.view.frame.height > self.view.frame.width ? (self.view.frame.width - (3 * padding))/2 : (self.view.frame.width - (3 * padding))/5
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieViewModel = self.viewModel.viewModelForMovieDetails(at: indexPath.row) else { return }
        
        let detailsView = MovieDetailsViewController(viewModel: movieViewModel)
        navigationController?.pushViewController(detailsView, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.movieCount - 1 {
            DataProvider.shared.fetchMovies()
        }
    }
}
