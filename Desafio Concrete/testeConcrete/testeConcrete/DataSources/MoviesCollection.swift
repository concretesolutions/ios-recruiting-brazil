//
//  MoviesCollection.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 12/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class MoviesCollectionDataSource:NSObject, UICollectionViewDataSource {
    
        var list = [1,2,3,4,5,6,7,8,9,10];
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView
              .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .black
            // Configure the cell
            return cell
    }
    

}
