//
//  MoviesListViewController.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

final class MoviesListViewController: UIViewController {
    // MARK: - Variables
    weak var coordinator: MoviesListCoordinator?
    weak var viewModel: MoviesListViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var genericErrorView: UIView!
    
    // MARK: - IBActions
    @IBAction func tryAgainAction(_ sender: Any) {
        viewModel?.didTapTryAgainButton()
    }
}

// MARK: - Events -
extension MoviesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        setupViewModelListener()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarTitle()
        viewModel?.viewWillAppear()
    }
}

// MARK: - Navigation Bar Title -
extension MoviesListViewController {
    private func setNavigationBarTitle(){
        coordinator?.tabBarController?.navigationItem.title = "Movies"
    }
}

// MARK: - CollectionView Setup -
extension MoviesListViewController {
    func setupCollectionView(){
        collectionView.registerCellForType(.movieCell)
    }
}

// MARK: - CollectionViewDelegate & DataSource -
extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.state.featuredMovies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.movieCell.rawValue, for: indexPath)
        guard let movies = viewModel?.state.featuredMovies, movies.count > indexPath.row else { return cell }
                 
        let movie = movies[indexPath.row]
        let isFavorite = viewModel?.isMovieFavorite(id: indexPath.row) ?? false
        
        if let movieCell = cell as? MovieCollectionViewCell {
            movieCell.setup(posterPath: movie.posterPath, title: movie.title, isFavorite: isFavorite)
            return movieCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (view.frame.width / 2)
        return CGSize(width: width, height: width * 1.333)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.movieWasTapped(id: indexPath.row)
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func setupSearchBar(){
        searchBar.isHidden = true
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search for a movie (ex: Batman)"
    }
    
    func enableSearchBar(){
        DispatchQueue.main.async { [weak self] in
            self?.searchBar.isHidden = false
        }
    }
    
    func disableSearchBar(){
        DispatchQueue.main.async { [weak self] in
            self?.searchBar.isHidden = true
        }
    }
    
    func unfocusSearchBar(){
        DispatchQueue.main.async { [weak self] in
            self?.searchBar.resignFirstResponder()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        unfocusSearchBar()
        if let searchText = searchBar.text, !searchText.isEmpty {
            viewModel?.searchButtonWasTapped(searchText: searchText)
        } else {
            viewModel?.searchWasCleared()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel?.searchWasCleared()
        }
    }
}

// MARK: - ViewModel -
extension MoviesListViewController {
    func setupViewModelListener(){
        viewModel?.callback = { [weak self] state in
            
            if state.presentLoading {
                self?.presentLoading()
            } else {
                self?.dismissLoading()
            }
            
            if state.presentGenericError {
                self?.disableSearchBar()
                self?.presentGenericError()
            } else {
                self?.dismissGenericError()
            }
            
            if state.presentEmptySearch {
                self?.enableSearchBar()
                self?.presentEmptySearchState(searchText: state.searchText)
            } else {
                self?.clearBackgroundView()
            }
            
            if state.searchText.isEmpty {
                self?.unfocusSearchBar()
            }
            
            if !state.featuredMovies.isEmpty || !state.searchText.isEmpty{
                self?.enableSearchBar()
            }
            
            if state.refreshFeaturedMovies {
                self?.refreshFeaturedMovies()
            }
            
            if let unwrappedMovie = state.selectedMovie, state.presentSelectedMovie {
                self?.selectedMovieDidChange(movie: unwrappedMovie)
            }
        }
    }
}

// MARK: - State UI Updates -
extension MoviesListViewController {
    func refreshFeaturedMovies(){
        DispatchQueue.main.async { [weak self] in 
            self?.collectionView.reloadData()
        }
        viewModel?.featuredMoviesDidRefresh()
    }
    
    // MARK: - Show selected movie
    func selectedMovieDidChange(movie: Movie) {
        coordinator?.startMovieDetail(movie: movie)
        viewModel?.selectedMovieDetailDidPresent()
    }
    
    // MARK: - Clear Background View
    func clearBackgroundView(){
        DispatchQueue.main.async { [weak self] in guard let self = self else { return }
            self.collectionView.backgroundView = UIView()
        }
    }
   
    // MARK: - Empty Search State
    func presentEmptySearchState(searchText: String){
        DispatchQueue.main.async { [weak self] in guard let self = self else { return }
            self.collectionView.backgroundView = EmptySearchView.instantiate(frame: self.collectionView.frame, emoji: "🧐", message: "No match for the search term \"\(searchText)\" has been found.")
        }
    }
    
    // MARK: - Loading
    func presentLoading(){
        DispatchQueue.main.async { [weak self] in guard let self = self else { return }
            self.loaderView.isHidden = false
            self.loaderView.alpha = 1.0
        }
    }
    
    func dismissLoading(){
        DispatchQueue.main.async { [weak self] in guard let self = self, !self.loaderView.isHidden else { return }
            self.loaderView.alpha = 0.0
            self.loaderView.isHidden = true
        }
    }
    
    // MARK: - Generic Error
    func presentGenericError(){
        DispatchQueue.main.async { [weak self] in guard let self = self else { return }
            self.genericErrorView.isHidden = false
            self.genericErrorView.alpha = 1.0
        }
    }
    
    func dismissGenericError(){
        DispatchQueue.main.async { [weak self] in guard let self = self, !self.genericErrorView.isHidden else { return }
            self.genericErrorView.alpha = 0.0
            self.genericErrorView.isHidden = true
        }
    }
}
