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
    private let SEGUEDETAILMOVIE = "segueDetailMovie"
    
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
        self.presenter.callServices()
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

//MARK: - DATASOURCE - UICollectionViewDataSource -
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewData.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieElementCollectionViewCell", for: indexPath) as? MovieElementCollectionViewCell else { return UICollectionViewCell() }
        cell.prepareCell(viewData: self.viewData.movies[indexPath.row])
        return cell
    }
}

//MARK: - DELEGATE - UICollectionViewDelegate -
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: self.SEGUEDETAILMOVIE, sender: self.viewData.movies[indexPath.row])
    }
}

//MARK: - DELEGATE - UICollectionViewDelegateFlowLayout -
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.collectionView.bounds.width
//        let widthCell = width * 0.44
//        return CGSize(width: widthCell, height: self.view.frame.height * 0.39)
        return CGSize(width: self.view.frame.width * 0.44, height: self.view.frame.height * 0.39)
    }
}


//MARK: - AUX METHODS -
extension MovieListViewController {
    private func registerCell() {
        self.collectionView.register(UINib(nibName: "MovieElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieElementCollectionViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MovieDetailViewController, let viewData = sender as? MovieElementViewData {
            controller.viewData = viewData
            controller.selectedFavorite = self.selecteFavorite
        }
    }
    
    private func selecteFavorite(id: Int64) {
        guard let index = self.viewData.movies.firstIndex(where: {$0.id == id}) else { return }
        self.viewData.movies[index].detail.isFavorited = !self.viewData.movies[index].detail.isFavorited
        let indexPath = IndexPath(row: index, section: 0)
        let cell = self.collectionView.cellForItem(at: indexPath)
    }
}
