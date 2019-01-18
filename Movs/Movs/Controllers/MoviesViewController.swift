//
//  ViewController.swift
//  Movs
//
//  Created by Franclin Cabral on 1/17/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.moviesCellIdentifier)
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 //TODO: Mudar para o datasource count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.moviesCellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        return cell
    }
}

