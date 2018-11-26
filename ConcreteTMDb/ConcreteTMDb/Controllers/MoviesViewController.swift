//
//  MoviesViewController.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 14/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var OutletMoviesCollectionView: MoviesCollectionView!
    @IBOutlet weak var OutletSearchBar: UISearchBar!
    @IBOutlet weak var OutletMessage: UILabel!
    @IBOutlet weak var OutletMessageImage: UIImageView!
    @IBOutlet weak var OutletMessageView: UIView!
    @IBOutlet weak var OutletActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var movieToShow: MoviesCollectionViewCell?
    var page = 1
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
        self.setupSearch()
        
        TMDataManager.moviesDataCompletedDelegate = self
        TMDataManager.exceptionDelegate = self
        TMDataManager.fetchMovies(page: self.page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.OutletMoviesCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        self.OutletMoviesCollectionView.layer.zPosition = -1
        self.OutletMoviesCollectionView.loadContent = self
        self.OutletMoviesCollectionView.movieSelected = self
        self.OutletMoviesCollectionView.delegate = self.OutletMoviesCollectionView
        self.OutletMoviesCollectionView.dataSource = self.OutletMoviesCollectionView
    }
    
    func setupSearch() {
        self.OutletSearchBar.layer.zPosition = 3
        self.OutletSearchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            guard let movieCell = self.movieToShow else { return }
            guard let detailVC = segue.destination as? MovieDetailViewController else { return }
            detailVC.movieCell = movieCell
        }
    }

}

extension MoviesViewController: MoviesDataFetchCompleted {
    func fetchComplete(for movies: [Movie]) {
        self.OutletMoviesCollectionView.movies = movies
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.OutletActivityIndicator.stopAnimating()
            self.OutletMoviesCollectionView.reloadData()
            self.OutletMoviesCollectionView.layer.zPosition = 1
        }
    }
}

extension MoviesViewController: MovieCellSelected {
    
    func didTap(at movieCell: MoviesCollectionViewCell) {
        self.movieToShow = movieCell
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Update CollectionView
        var moviesSearched: [Movie] = []
        
        if !searchText.isEmpty {
            let locale = Locale(identifier: "en_US_POSIX")
            let formattedText = searchText.lowercased().folding(options: .diacriticInsensitive, locale: locale)
            
            moviesSearched = TMDataManager.movies.filter { (movie) -> Bool in
                movie.title.lowercased().folding(options: .diacriticInsensitive, locale: locale).range(of: formattedText) != nil
            }
            self.OutletMoviesCollectionView.movies = moviesSearched
            
            if moviesSearched.count == 0 {
        
                // Empty Search
                self.presentEmptySearchMessage(with: searchText)
                
            } else {
                self.OutletMoviesCollectionView.layer.zPosition = 1
            }
        } else {
            self.OutletMoviesCollectionView.movies = TMDataManager.movies
        }
        self.OutletMoviesCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.OutletSearchBar.resignFirstResponder()
    }
}

extension MoviesViewController: PresentMessageForException {
    func presentEmptySearchMessage(with searchText: String) {
        self.OutletMoviesCollectionView.layer.zPosition = -1
        self.OutletMessageImage.image = UIImage(named: "search_icon")
        self.OutletMessage.text = "Sua busca por \(searchText) não resultou em nenhum resultado"
    }
    
    func presentGenericErrorMessage() {
        self.OutletMoviesCollectionView.layer.zPosition = -1
        self.OutletMessageImage.image = UIImage(named: "error_icon")
        self.OutletMessage.text = "Um erro ocorreu. Por favor, tente novamente."
    }
}

extension MoviesViewController: LoadMoreContentAfterPagination {
    func loadMoreMovies() {
        
        if self.OutletSearchBar.text == "" {
            self.page += 1
            TMDataManager.fetchMovies(page: self.page)
        }
    }
}


