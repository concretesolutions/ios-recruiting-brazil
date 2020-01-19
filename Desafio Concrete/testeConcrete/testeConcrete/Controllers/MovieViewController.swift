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

extension MovieViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.width/2.2 + 100)
    }
}
