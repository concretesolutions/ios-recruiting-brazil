//
//  MovieListViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: MovieListPresenter!
    private lazy var viewData:MovieListViewData = MovieListViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension MovieListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieListPresenter(viewDelegate: self)
        self.registerCell()
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieListViewController: MovieListViewDelegate {

}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieElementCollectionViewCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.width
        let cellWidth = (width - 30) / 2
        return CGSize(width: cellWidth, height: cellWidth / 0.6)
    }
}

//MARK: - AUX METHODS -
extension MovieListViewController {
    private func registerCell() {
        self.collectionView.register(UINib(nibName: "MovieElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieElementCollectionViewCell")
    }
}
