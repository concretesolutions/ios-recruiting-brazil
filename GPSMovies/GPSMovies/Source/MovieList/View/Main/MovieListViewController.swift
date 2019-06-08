//
//  MovieListViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Lottie

class MovieListViewController: UIViewController {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewLoadingOrError: UIView!
    @IBOutlet weak var viewImageLoading: AnimationView!
    
    // MARK: CONSTANTS
    private let SEGUEDETAILMOVIE = "segueDetailMovie"
    
    // MARK: VARIABLES
    private var presenter: MovieListPresenter!
    private lazy var viewData:MovieListViewData = MovieListViewData()
    private var isLoading = false
    
    // MARK: IBACTIONS
    
    deinit {
        self.removeObserver()
    }
}

//MARK: - LIFE CYCLE -
extension MovieListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieListPresenter(viewDelegate: self)
        self.presenter.callServices()
        self.registerCell()
        self.registerObserver()
        self.setupView()
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieListViewController: MovieListViewDelegate {
    
    func showLoading() {
        self.collectionView.isHidden = true
        UIView.animate(withDuration: 0.4, animations: {
            self.viewLoadingOrError.isHidden = false
        }) { (_) in
            self.viewImageLoading.play()
            self.viewImageLoading.loopMode = .loop
        }
    }
    
    func showError() {
        let animation = Animation.named("error")
       
        UIView.animate(withDuration: 0.4, animations: {
            self.viewImageLoading.animation = animation
            self.viewImageLoading.play()
        }) { (_) in
            
            
        }
    }
    
    func showEmptyList() {
        
    }
    
    func setViewData(viewData: MovieListViewData) {
        self.viewData = viewData
        self.collectionView.reloadData()
        self.collectionView.alpha = 0
        self.collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.viewLoadingOrError.isHidden = true
            self.collectionView.alpha = 1
        }
    }
    
    func setViewDataOfNextPage(viewData: MovieListViewData) {
        self.viewData.currentPage = viewData.currentPage
        self.viewData.totalPages = viewData.totalPages
        self.viewData.movies += viewData.movies
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewData.movies.count - 10, !self.isLoading, self.viewData.totalPages != self.viewData.currentPage {
            self.viewData.currentPage += 1
            self.presenter.getMovies(for: self.viewData.currentPage)
        }
    }
}

//MARK: - DELEGATE - UICollectionViewDelegateFlowLayout -
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.44, height: self.view.frame.height * 0.39)
    }
}


//MARK: - AUX METHODS -
extension MovieListViewController {
    private func registerCell() {
        self.collectionView.register(UINib(nibName: "MovieElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieElementCollectionViewCell")
    }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.selecteFavorite(_:)), name: Notification.Name(rawValue: "observerFavorite"), object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "observerFavorite"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MovieDetailViewController, let viewData = sender as? MovieElementViewData {
            controller.viewData = viewData
        }
    }
    
    @objc func selecteFavorite(_ notification: Notification) {
        guard let object = notification.object as? [String: Int64], let id = object["id"] as? Int64, let index = self.viewData.movies.firstIndex(where: {$0.id == id}) else { return }
        self.viewData.movies[index].detail.isFavorited = !self.viewData.movies[index].detail.isFavorited
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? MovieElementCollectionViewCell else { return }
        if self.viewData.movies[index].detail.isFavorited {
            cell.showFavorite()
        }else {
            cell.hideFavorite()
        }
    }
    
    private func setupView() {
        let animation = Animation.named("loading")
        viewImageLoading.animation = animation
    }
}
