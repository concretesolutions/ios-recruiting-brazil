//
//  MoviesGridCollectionDataSource.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class MoviesGridCollectionDataSource: NSObject, UICollectionViewDataSource{
    
    var movies:[Movie] = []
    
    required init(movies:[Movie], collectionView: UICollectionView) {
        self.movies = movies
        super.init()
        collectionView.register(cellType: MoviesGridCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MoviesGridCollectionViewCell.self)
        cell.setup(movie: movies[indexPath.row])
        return cell
    }
}

class MoviesGridCollectionDelegate: NSObject, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    let movies:[Movie]!
    let numberOfItems = 2
    
    init(movies: [Movie]){
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = CGFloat(numberOfItems)
        let width = (UIScreen.main.bounds.width - Design.Insets.moviesGridCollection.right * (items + 1)) / items
        return CGSize(width: width, height: width * 1.50)
    }
    
    
}
