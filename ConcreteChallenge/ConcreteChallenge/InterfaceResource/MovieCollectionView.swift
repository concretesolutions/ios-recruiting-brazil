//
//  MovieCollectionView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 12/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class MovieCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    var movies: [Movie] = []
    
    // MARK: - UICollectionViewDelegate Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}
