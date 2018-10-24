//
//  BaseCollectionViewController.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

class BaseCollectionViewController<T: BaseCollectionViewCell<U>, U>: UICollectionViewController {
    let cellID = "cellID"
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(T.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}
