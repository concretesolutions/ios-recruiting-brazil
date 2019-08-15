//
//  MovieGridController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit


//MARK: - Controller of the MovieGrid Screen
class MovieGridController: UIViewController {
    
    let screen = MovieGridView()
    let viewModel = MovieGridViewModel()
    
    override func loadView() {
        self.view = screen
 
        screen.gridView.delegate = self
        screen.gridView.dataSource = self
    }

}


//MARK: - Collection DataSource Methods
extension MovieGridController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGridCell.reuseIdentifier, for: indexPath) as! MovieGridCell
        return cell
    }
}


//MARK: - Collection Layout Methods
extension MovieGridController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
}

