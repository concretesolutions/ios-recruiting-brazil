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
    
    // MARK: - Initializers
    
    init(collectionView: MoviesCollectionView) {
        self.collectionView = collectionView
//        self.collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - UICollectionViewDataSource protocol functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let movieCell = reusableCell as? MovieCollectionViewCell {
            movieCell.set(movie: self.movies[indexPath.row])
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
    
    func set(image: UIImage, forIndex index: Int) {
        let section = index/2
        let row = index - (2 * section)
        let indexPath = IndexPath(row: row, section: section)
        
        if let movieCell = self.collectionView?.cellForItem(at: indexPath) as? MovieCollectionViewCell{
            movieCell.set(image: image)
        }
        
    }
    
    
}
