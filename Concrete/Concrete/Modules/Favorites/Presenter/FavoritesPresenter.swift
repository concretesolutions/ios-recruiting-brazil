//
//  FavoritesPresenter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class FavoritesPresenter {
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router: FavoritesRouter
    var interactor: FavoritesInteractor
    var view: FavoritesCollectionViewController
    
    // MARK: - Initializers
    init(router: FavoritesRouter, interactor: FavoritesInteractor, view: FavoritesCollectionViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        self.view.presenter = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        //
    }
    
    func viewWillAppear() {
        self.view.collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.interactor.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell-dafult", for: indexPath) as? FavoritesCollectionViewCell else {
            Logger.logError(in: self, message: "Could not cast to FavoritesCollectionViewCell")
            return UICollectionViewCell()
        }
        
        
        let movie = self.interactor.movies[indexPath.row]
        
        cell.set(name: movie.title)
        cell.set(imagePath: movie.posterPath)
        cell.set(isFavorite: movie.isFavorited)
        
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.interactor.movies[indexPath.row]
        
        self.router.goToMoviewDetail(movie:movie)
    }
}

extension FavoritesPresenter: FavoritesCollectionViewCellDelegate {
    func didTap(isFavorited: Bool, in cell: FavoritesCollectionViewCell) {
        guard let indexPath = self.view.collectionView.indexPath(for: cell) else {
            Logger.logError(in: self, message: "")
            return
        }
        let movie = self.interactor.movies[indexPath.row]
        self.interactor.set(movie: movie, isFavorited: isFavorited)
        
        self.view.collectionView.deleteItems(at: [indexPath])
    }
}
