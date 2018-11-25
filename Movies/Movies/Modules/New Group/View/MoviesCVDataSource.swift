//
//  MoviesCollectionViewDataSource.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Movie"

class MoviesCVDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    private var movies: [Movie] = []
    private weak var collectionView: MoviesCollectionView?
    private var presenter: MoviesPresentation
    
    // MARK: - Initializers
    
    init(collectionView: MoviesCollectionView, presenter: MoviesPresentation) {
        self.collectionView = collectionView
        self.presenter = presenter
    }
    
    // MARK: - UICollectionViewDataSource protocol functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let movieCell = reusableCell as? MovieCollectionViewCell {
            movieCell.poster.image = nil
            movieCell.set(movie: self.movies[indexPath.row])
            movieCell.presenter = self.presenter
        }
        
        return reusableCell
    }
    
    // MARK: - Util functions
    
    func update(movies: [Movie]) {
        self.movies = movies
        self.collectionView?.reloadData()
    }
    
    func add(movies: [Movie]) {
        
    }
    
}
