//
//  MoviesPresenter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesPresenter: NSObject {
    
    // MARK: - VIPER
    var view: MoviesView
    var interactor: MoviesInteractor
    var router: MoviesRouter
    
    init(router: MoviesRouter, interactor: MoviesInteractor, view: MoviesView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.interactor.presenter = self
        self.view.presenter = self
    }
    
    // FROM VIEW
    
    func didLoad() {
        self.interactor.fetchMovies()
    }
    
    func totalMovies() -> Int {
        return self.interactor.getTotalMovies()
    }
    
    // FROM INERECTOR
    
    func loadedMovies() {
        self.view.showPopularMovies()
    }
    
}

// MARK: - UICollectionViewDataSource
extension MoviesPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.getTotalMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Prepare cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        // Get movie
        let movie = self.interactor.getMovie(at: indexPath.item)
        cell.awakeFromNib(title: movie.title)
        // Load image
        if let image = movie.poster_path {
            let imageURL = "https://image.tmdb.org/t/p/w500\(image)" // w500 original
            cell.setup(imageURL: imageURL)
        }
        return cell
    }
    
}
