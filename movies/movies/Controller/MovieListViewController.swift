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
    var viewModel: MovieListViewModel!
    var screen: MovieListViewControllerScreen!
    
    var query = PassthroughSubject<String?, Never>() // String written in search bar
    
    override func loadView() {
        viewModel = MovieListViewModel(query: query.eraseToAnyPublisher())
        
        screen = MovieListViewControllerScreen(frame: UIScreen.main.bounds, state: viewModel.$state.eraseToAnyPublisher())
        screen.collectionView.dataSource = self
        screen.collectionView.delegate = self
        
        self.view = screen
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = search
        self.navigationItem.searchController!.searchBar.delegate = self // Set the serach bar delegate to this
        
        self.title = "Movies"
        self.query.send("")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.viewModel.$movieCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.perform(#selector(self?.loadCollectionView), with: nil, afterDelay: 1.0)
            }
    }
    
    @objc func loadCollectionView() {
        self.screen.collectionView.reloadData()
    }
}

// MARK: - SearchBar
extension MovieListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.query.send(searchBar.text) // Send changes in query string value
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.query.send(searchBar.text) // Send changes in query string value
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
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
        let width: CGFloat = 180
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
            self.viewModel.fetchMovies()
        }
    }
}
