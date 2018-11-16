//
//  FilmsDataSource.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsDataSource: NSObject, UICollectionViewDataSource {
    
    var films: [Film]!
    
    init(withCollection collection: UICollectionView, andFilms films: [Film]){
        self.films = films
        super.init()
        collection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
//        cell.setup(film: films[indexPath.row])
        return cell
    }
    

}
