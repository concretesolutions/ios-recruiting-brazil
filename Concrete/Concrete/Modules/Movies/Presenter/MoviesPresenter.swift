//
//  MoviesPresenter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MoviesPresenter: NSObject {
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router: MoviesRouter
    var interactor: MoviesInteractor
    var view: MoviesViewController
    
    // MARK: - Initializers
    init(router: MoviesRouter, interactor: MoviesInteractor, view: MoviesViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        self.view.presenter = self
        self.interactor.delegate = self
        
        self.reload()
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        //
    }
    
    @objc func reload() {
        self.interactor.fetchMovies()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interactor.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell-Default", for: indexPath) as? MovieCollectionViewCell else {
            Logger.logError(in: self, message: "Could not cast to MovieCollectionViewCell-Default")
            return UICollectionViewCell()
        }
        
        let movie = self.interactor.movies[indexPath.row]
        
        cell.set(name: movie.title)
        cell.set(imagePath: movie.posterPath)
        cell.set(isFavorited: movie.isFavorite)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.interactor.movies[indexPath.row]
        
        self.router.goToMoviewDetail(movie:movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.interactor.movies.count-10 == indexPath.row {
            self.interactor.fetchMovies(page: self.interactor.page+1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MoviesSearchCollectionReusableView-default", for: indexPath) as? MoviesSearchCollectionReusableView else {
                Logger.logError(in: self, message: "Could not cast UICollectionReusableView to MoviesSearchCollectionReusableView")
                return UICollectionReusableView()
            }
            
            headerView.outletSearchBar.delegate = self
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
}

extension MoviesPresenter: MoviesInteractorDelegate {
    func isLoading(_ loading: Bool) {
        self.view.isLoading = loading
    }
    
    func didLoad() {
        DispatchQueue.main.async {
            self.view.collectionView?.reloadData()
            self.view.collectionView?.refreshControl?.endRefreshing()
        }
    }
    
    func didFail(error: Error) {
        DispatchQueue.main.async {
//            self.router.showAlert(message: error.localizedDescription)
            self.view.collectionView?.refreshControl?.endRefreshing()
        }
    }
}

extension MoviesPresenter: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            searchBar.text = ""
            self.interactor.cancelSearch()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.interactor.fetchSearchMovies(query: text)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == nil || searchBar.text?.isEmpty ?? false {
            self.interactor.cancelSearch()
        }
    }
}
