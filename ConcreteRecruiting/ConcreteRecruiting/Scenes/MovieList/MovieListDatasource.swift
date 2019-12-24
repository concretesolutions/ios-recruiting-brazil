//
//  MovieListDatasource.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 21/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieListDataSource: NSObject, UICollectionViewDataSource {
    
    let viewModel: MovieListViewModel
    
    init(with viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionCell else {
            fatalError("Unable to dequeue a cell with the MovieCell identifier")
        }
        
        let cellViewModel = viewModel.getViewModel(for: indexPath)
        
        cell.setup(with: cellViewModel)
        
        
        return cell
    }
    
}
