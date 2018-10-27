//
//  MovieGridDataSource.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

final class MovieGridDataSource: NSObject {

    var viewModels = [MovieGridViewModel]()
    
    deinit {
        print("data source")
    }
}

extension MovieGridDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGridCollectionView.reuseIdentifier, for: indexPath) as? MovieGridCollectionViewCell {
            cell.movieGridUnit.viewModel = self.viewModels[indexPath.row]
            
            return cell
        } else {
            return UICollectionViewCell(frame: .zero)
        }
    }

}
