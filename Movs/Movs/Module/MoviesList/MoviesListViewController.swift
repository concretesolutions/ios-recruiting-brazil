//
//  MoviesListViewController.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    private var moviesCollectionView = MoviesListCollectionView()
    
    var viewModel = MoviesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.moviesCollectionView)
        NSLayoutConstraint.activate([
            self.moviesCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.moviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        
        self.viewModel.fetchMovies {
            self.moviesCollectionView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.moviesCollectionView.cellSize
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCollectionView.MOVIE_CELL_IDENTIFIER, for: indexPath)
        
        if let cellViewModel = self.viewModel.getViewModelForCell(at: indexPath), cell is MovieCollectionCell {
            (cell as! MovieCollectionCell).viewModel = cellViewModel
        }
        
        return cell
    }
    
    
}
