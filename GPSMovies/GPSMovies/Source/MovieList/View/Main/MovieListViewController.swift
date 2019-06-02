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
        self.presenter.getPopularMovies()
        self.registerCell()
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieListViewController: MovieListViewDelegate {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showError() {
        
    }
    
    func showEmptyList() {
        
    }
    
    func setViewData(viewData: MovieListViewData) {
        self.viewData = viewData
        self.collectionView.reloadData()
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewData.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieElementCollectionViewCell", for: indexPath) as? MovieElementCollectionViewCell else { return UICollectionViewCell() }
        cell.prepareCell(viewData: self.viewData.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = self.view.frame.width * 0.46
         return CGSize(width: widthCell, height: (widthCell / 0.47))
    }
}

//MARK: - AUX METHODS -
extension MovieListViewController {
    private func registerCell() {
        self.collectionView.register(UINib(nibName: "MovieElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieElementCollectionViewCell")
    }
}
