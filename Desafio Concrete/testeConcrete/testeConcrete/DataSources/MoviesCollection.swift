//
//  MoviesCollection.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 12/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class MoviesCollectionDataSource:NSObject, UICollectionViewDataSource {
    
    
    
    override init(){
        super.init()
    }
    var list:[Category] = [];
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
