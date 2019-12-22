//
//  MovieListDatasource.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 21/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieListDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionCell else {
            fatalError("Unable to dequeue a cell with the MovieCell identifier")
        }
        
        cell.bannerImageView.image = #imageLiteral(resourceName: "Favorite-filled")
        cell.titleLabel.text = "Harry Potter"
        
        return cell
    }
    
}
