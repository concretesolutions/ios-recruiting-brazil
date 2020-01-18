//
//  MovieCollectionDelegate.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 11/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController:UIViewController{
    var list       = [1,2,3,4,5,6,7,8,9,10];
    let dataSource = MoviesCollectionDataSource()
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension MovieViewController{
    override func viewDidLoad() {
        collectionView.dataSource = self.dataSource
    }
}

extension MovieViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
