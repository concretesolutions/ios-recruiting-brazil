//
//  PopularMoviesView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol MovieCellSelected {
    func didTapMovieCell(of movie: Movie)
}

class PopularMoviesViewController: UIViewController, PopularMoviesView, MovieCellSelected {
    
    
    // MARK: - Outlets
    @IBOutlet weak var moviesCollectionView: MovieCollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var presenter: PopularMoviesPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupNavigationBar()
        
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

    func setActivityIndicator(to activated: Bool) {
        if activated {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    // MARK: -  MovieCellSelected Functions
    func didTapMovieCell(of movie: Movie) {
        self.presenter.didTapMovieCell(of: movie)
    }
    
    // MARK: - Functions
    func setupNavigationBar() {
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
    }
    
    func setupCollectionView() {
        self.moviesCollectionView.delegate = self.moviesCollectionView
        self.moviesCollectionView.dataSource = self.moviesCollectionView
        self.moviesCollectionView.cellSelected = self
    }
}
