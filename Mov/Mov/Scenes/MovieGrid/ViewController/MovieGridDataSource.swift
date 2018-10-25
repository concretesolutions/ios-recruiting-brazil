//
//  MovieGridDataSource.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

final class MovieGridDataSource: NSObject {

    private var movies: [MovieGridViewModel] = []
    
    private let collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
}


extension MovieGridDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell(frame: .zero)
    }

}

extension MovieGridDataSource: MovieGridViewOutput {
    
    func display(movies: [MovieGridViewModel]) {
        self.movies = movies
        self.collectionView.reloadData()
    }
    
    func displayNetworkError() {
        
    }
    
    
}
