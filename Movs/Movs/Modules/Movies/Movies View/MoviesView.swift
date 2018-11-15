//
//  ViewController.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesView: UIViewController {
    
    // MARK: - VIPER
    var presenter: MoviesPresenter!
    
    // MARK: - Outlets
    @IBOutlet weak var outletMoviesCollection: UICollectionView!
    
    // MARK: - Outlets Views
    @IBOutlet weak var outletMoviesError: MoviesViewError!
    @IBOutlet weak var outletMoviesNoResults: MoviesViewNoResults!
    @IBOutlet weak var outletMoviesLoading: MoviesViewLoading!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup Collection Delegates
        self.outletMoviesCollection.delegate = self
        self.outletMoviesCollection.dataSource = self.presenter //self.presenter.interactor
        
        // Setup Error View
        self.outletMoviesError.isHidden = true
        self.outletMoviesError.setup(movieView: self)
        // Setup NoResults View
        self.outletMoviesNoResults.isHidden = true
        self.outletMoviesNoResults.setup(movieView: self)
        // Setup Loading View
        self.outletMoviesLoading.isHidden = false
        self.outletMoviesLoading.setup(movieView: self)
        
        // VIPER
        self.presenter.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.outletMoviesCollection.reloadData()
    }
    
    // FROM NAVIGATION
    
    func selectedMovie(at index: Int) {
        self.presenter.selectedMovie(at: index)
    }
    
    func searchEnded() {
        self.presenter.searchMovieEnded()
    }
    
    func search(text: String) {
        self.presenter.searchMovie(containing: text)
    }
    
    // FROM PRESENTER
    
    func showPopularMovies() {
        self.outletMoviesLoading.isHidden = true
        self.outletMoviesError.isHidden = true
        self.outletMoviesNoResults.isHidden = true
        self.outletMoviesCollection.reloadData()
    }
    
    func showError() {
        self.outletMoviesLoading.isHidden = true
        self.outletMoviesError.isHidden = false
    }
    
    func showNoResults() {
        self.outletMoviesLoading.isHidden = true
        if let searchText = self.navigationItem.searchController?.searchBar.text {
            self.outletMoviesNoResults.noResult(searchText: searchText)
        }
        self.outletMoviesNoResults.isHidden = false
    }
    
    // INTERACTIONs METHODs
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewInteractionStarted()
    }
    
    func scrollViewInteractionStarted() {
        // Recolhe teclado
        self.navigationItem.searchController?.searchBar.endEditing(true)
        // Interagindo sem texto de pesquisa = Recolhe pesquisa
        if let searchText = self.navigationItem.searchController?.searchBar.text {
            if searchText.isEmpty {
                self.navigationItem.searchController?.isActive = false
            }
        }
    }
    
}
