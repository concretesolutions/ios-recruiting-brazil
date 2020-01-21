//
//  PopularMoviesViewController.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 13/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    var popularMoviesView: PopularMoviesView {
        return self.view as! PopularMoviesView
    }
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchText: String = ""
    private var filteredMovies: [Movie] = []
    private var isFiltering: Bool {
      return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    private let movieDetailsVC = MovieDetailsViewController()
    
    private var isFetchingNewPage: Bool = true
    private var isFetchingFirstPage: Bool = true
    
    // Private Methods
    
    private func initController() {
        self.view = PopularMoviesView()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        movieDetailsVC.setCustomNavigationBar(title: "Movie Details", color: .mvText)
        
        popularMoviesView.collectionView.dataSource = self
        popularMoviesView.collectionView.delegate = self
        popularMoviesView.collectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier)
        
        PopularMovieCollectionViewCell.setSize(screenSize: UIScreen.main.bounds.size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didDownloadPage), name: TmdbAPI.didDownloadPageNN, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(genericErrorDidHappen), name: TmdbAPI.genericErrorNN, object: nil)
        
        popularMoviesView.collectionView.isUserInteractionEnabled = false
        
        TmdbAPI.fetchPopularMoviesSet()
    }
    
    @objc private func genericErrorDidHappen() {
        self.popularMoviesView.errorView.isHidden = false
    }
    
    @objc private func didDownloadPage() {
        DispatchQueue.main.async {
            self.filterAPIMovies()
            self.isFetchingNewPage = false
            self.isFetchingFirstPage = false
            self.popularMoviesView.collectionView.reloadData()
            self.popularMoviesView.collectionView.isUserInteractionEnabled = true
        }
    }
    
    private func filterLocalMovies(for searchText: String) {
        self.filteredMovies = TmdbAPI.movies.filter({ (movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }).sorted(by: { (a, b) -> Bool in
            if a.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                if b.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                    return a.title.lowercased() < b.title.lowercased()
                }
                else {
                    return true
                }
            }
            else if b.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                return false
            }
            else {
                return a.title.lowercased() < b.title.lowercased()
            }
        })
        
        DispatchQueue.main.async {
            self.popularMoviesView.collectionView.reloadData()
        }
    }
    
    private func filterAPIMovies() {
        self.filteredMovies = TmdbAPI.movies.filter({ (movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }).sorted(by: { (a, b) -> Bool in
            if a.searchIndex != nil {
                if b.searchIndex != nil {
                    return a.searchIndex! < b.searchIndex!
                }
                return true
            }
            else if b.searchIndex != nil {
                return false
            }
            
            if a.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                if b.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                    return a.title.lowercased() < b.title.lowercased()
                }
                return true
            }
            else if b.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                return false
            }
            return a.title.lowercased() < b.title.lowercased()
        })
    }
}

// MARK: - CollectionView Delegate
extension PopularMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isFetchingFirstPage {
            return 10
        }
        if self.isFiltering {
            if filteredMovies.count == 0 && !self.isFetchingNewPage{
                self.popularMoviesView.emptyView.searchText = self.searchText
                self.popularMoviesView.emptyView.isHidden = false
            }
            else {
                self.popularMoviesView.emptyView.isHidden = true
            }
            
            return filteredMovies.count
        }
        else {
            self.popularMoviesView.emptyView.isHidden = true
            return TmdbAPI.popularMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier, for: indexPath) as! PopularMovieCollectionViewCell
        
        if !self.isFetchingFirstPage{
            let movie = self.isFiltering ? filteredMovies[indexPath.row] : TmdbAPI.popularMovies[indexPath.row]
            cell.fill(movie: movie)
        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PopularMovieCollectionViewCell.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.isFetchingNewPage { return }
        if self.isFiltering, indexPath.row >= filteredMovies.count - 1 {
            self.isFetchingNewPage = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                TmdbAPI.fetchMovies(query: self.searchText, newSearch: false)
            }
            
            return
        }
        if indexPath.row >= TmdbAPI.popularMovies.count - 1 {
            self.isFetchingNewPage = true
            TmdbAPI.fetchPopularMoviesSet()
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.isFetchingFirstPage {
            let movie = self.isFiltering ? filteredMovies[indexPath.row] : TmdbAPI.popularMovies[indexPath.row]
            movieDetailsVC.movie = movie
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}

// MARK: - Search Controller Update
extension PopularMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.isFetchingNewPage = true
            searchText = text
            filterLocalMovies(for: text)
            TmdbAPI.fetchMovies(query: text, newSearch: true)
        }
        else {
            DispatchQueue.main.async {
                TmdbAPI.searchTask.cancel()
                self.popularMoviesView.collectionView.reloadData()
                self.isFetchingNewPage = false
            }
        }
    }
}
