//
//  MoviesGridCollectionDataSource.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit

final class MoviesGridCollectionDataSource: NSObject, UICollectionViewDataSource{
    
    var movies:[Movie] = []
    
    required init(movies:[Movie], collectionView: UICollectionView) {
        self.movies = movies
        super.init()
        //FIXME: register cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //FIXME:- finish implementation, call cell from pod reusable
        //let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: Mov.self)
        return UICollectionViewCell()
    }
    
    
}
