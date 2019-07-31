//
//  MoviesGridDatasourceMock.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
@testable import TheMovies

class MoviesGridDatasourceMock: UIView, UICollectionViewDataSource {
    
    private var store: MovieStoreMock
    
    init(store: MovieStoreMock) {
        self.store = store
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.mock.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = store.mock[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesGridCell", for: indexPath) as! MoviesGridCell
        let movieCell = cell
        movieCell.label.text = data.title
        movieCell.image.image = data.image
        movieCell.id = data.id
        movieCell.favorite.image = !data.liked ? UIImage(named: "favorite_gray_icon")! : UIImage(named: "favorite_full_icon")!
        movieCell.didMoveToWindow()
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
}
