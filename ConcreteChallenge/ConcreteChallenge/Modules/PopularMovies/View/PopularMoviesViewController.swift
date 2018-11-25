//
//  PopularMoviesView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol MovieCollectionViewActions {
    func didTapMovieCell(of movie: Movie)
    func didReachEndOfCollectionView()
}

class PopularMoviesViewController: UIViewController, PopularMoviesView, MovieCollectionViewActions {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: MovieCollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Properties
    var presenter: PopularMoviesPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupNavigationBar()
        
        self.setupSearchBar()
        
        self.setupCollectionView()
        self.presenter.didRequestMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.moviesCollectionView.reloadData()
    }
    
    // MARK: - PopularMoviesView Functions
    func show(movies: [Movie]) {
        self.moviesCollectionView.isHidden = false
        self.moviesCollectionView.movies = movies
    }
    
    func showErrorMessage() {
        DispatchQueue.main.async {
            if self.moviesCollectionView.isHidden == true {
                self.errorImage.isHidden = false
                self.errorMessageLabel.isHidden = false
            }
        }
    }

    func setActivityIndicator(to activated: Bool) {
        if activated {
            self.activityIndicator.startAnimating()
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true                
            }
        }
    }
    
    // MARK: -  MoviesCollectionViewActions Functions
    func didTapMovieCell(of movie: Movie) {
        self.presenter.didTapMovieCell(of: movie)
    }
    
    func didReachEndOfCollectionView() {
        // Check if the searc bar is in use.
        // If it is use it should not fetch more movies
        if self.searchBar.text == "" {
            self.presenter.didRequestMovies()
        }
    }
    
    // MARK: - Functions
    func setupNavigationBar() {
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    func setupCollectionView() {
        self.moviesCollectionView.delegate = self.moviesCollectionView
        self.moviesCollectionView.dataSource = self.moviesCollectionView
        self.moviesCollectionView.collectionViewActions = self
    }
}

extension PopularMoviesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Erase Search
        self.searchBar.text = nil
        self.presenter.didChangeSearchBar(with: "")
        
        // Hide cancel button
        self.searchBar.showsCancelButton = false
        
        // Hide Keyboard
        self.resignFirstResponder()
        self.searchBar.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.didChangeSearchBar(with: searchText)
    }
}

