//
//  PopularMoviesView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController, PopularMoviesView {
    
    // MARK: - Outlets
    @IBOutlet weak var moviesCollectionView: MovieCollectionView!
    
    // MARK: - Properties
    var presenter: PopularMoviesPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupCollectionView()
        self.presenter.didRequestMovies()
    }
    
    // MARK: - PopularMoviesView Functions
    func show(movies: [Movie]) {
        self.moviesCollectionView.movies = movies
    }
    
    // MARK: - Functions
    func setupCollectionView() {
        self.moviesCollectionView.delegate = self.moviesCollectionView
        self.moviesCollectionView.dataSource = self.moviesCollectionView
    }
}

