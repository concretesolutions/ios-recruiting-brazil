//
//  MoviesCollection.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

extension MoviesView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-> Selected: \(indexPath.item)")
    }
    
}
