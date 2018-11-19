//
//  MoviesDataSource.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

final class MoviesDataSource:NSObject{
    
    var movies:[Movie] = []
    weak var collectionView:UICollectionView?
    weak var delegate:UICollectionViewDelegate?
    
    required init(movies:[Movie], collectionView:UICollectionView, delegate:UICollectionViewDelegate) {
        self.movies = movies
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        self.collectionView?.register(cellType: MovieCollectionViewCell.self)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = delegate
        self.collectionView?.reloadData()
        
    }
    
    func updateMovies(_ movies:[Movie]){
        self.movies = movies
        self.collectionView?.reloadData()
    }
    
}

extension MoviesDataSource: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.movies.count
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        
        let movie = self.movies[indexPath.item]
        cell.setup(withMovie: movie)
        
        return cell
    }
    
}
