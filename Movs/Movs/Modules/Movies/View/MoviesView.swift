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
    @IBOutlet weak var outletMoviesError: MoviesViewError!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup Collection Delegates
        self.outletMoviesCollection.delegate = self
        self.outletMoviesCollection.dataSource = self.presenter //self.presenter.interactor
        
        // Setup Error View
        self.outletMoviesError.isHidden = true
        self.outletMoviesError.setup(movieView: self)
        
        // FIXME: - Gesture Any Type
        // Setup Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.view.addGestureRecognizer(tap)
        
        // VIPER
        self.presenter.fetchMovies()
    }
    
    // FROM NAVIGATION
    
    func searchEnded() {
        self.presenter.searchMovieEnded()
    }
    
    func search(text: String) {
        self.presenter.searchMovie(containing: text)
    }
    
    // FROM PRESENTER
    
    func showPopularMovies() {
        self.outletMoviesError.isHidden = true
        self.outletMoviesCollection.reloadData()
    }
    
    func showError() {
        self.outletMoviesError.isHidden = false
    }
    
    // GESTUREs METHODs
    
    @objc func endEditing() {
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
