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
    @IBOutlet weak var viewContainerLottie: AnimationView!
    @IBOutlet weak var viewSuccess: UIView!
    @IBOutlet weak var viewEmprySearch: AnimationView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelError: UILabel!
    
    // MARK: CONSTANTS
    private let SEGUEDETAILMOVIE = "segueDetailMovie"
    
    // MARK: VARIABLES
    private var presenter: MovieListPresenter!
    private lazy var viewData:MovieListViewData = MovieListViewData()
    private lazy var moviesSearch = [MovieElementViewData]()
    private var isLoading = false
    private var isUsingSearchBar = false
    
    // MARK: IBACTIONS
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        self.isUsingSearchBar = false
        self.searchBar.text = ""
        self.hideKeyBoard()
        self.moviesSearch.removeAll()
        if self.viewLoadingOrError.isHidden, self.viewEmprySearch.isHidden {
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
       self.presenter.callServices()
    }
    
    @objc func selecteFavorite(_ notification: Notification) {
        guard let object = notification.object as? [String: Int64], let id = object["id"], let index = self.viewData.movies.firstIndex(where: {$0.id == id}) else { return }
        self.viewData.movies[index].detail.isFavorited = !self.viewData.movies[index].detail.isFavorited
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? MovieElementCollectionViewCell else { return }
        if self.viewData.movies[index].detail.isFavorited {
            cell.showFavorite()
        }else {
            cell.hideFavorite()
        }
    }
    
    @objc private func hideKeyBoard() {
        self.view.endEditing(true)
        self.view.gestureRecognizers?.removeAll()
    }
    
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
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieListViewController: MovieListViewDelegate {
    
    func showLoading() {
        self.viewSuccess.isHidden = true
        self.labelError.isHidden = true
        LottieHelper.showAnimateion(for: .loading, lottieView: self.viewContainerLottie, in: self.viewLoadingOrError)
        self.viewContainerLottie.loopMode = .loop
    }
    
    func showError() {
        self.viewSuccess.isHidden = true
        self.labelError.isHidden = false
        LottieHelper.showAnimateion(for: .error, lottieView: self.viewContainerLottie, in: self.viewLoadingOrError)
        viewContainerLottie.loopMode = .autoReverse
    }
    
    func setViewData(viewData: MovieListViewData) {
        self.viewData = viewData
        self.collectionView.reloadData()
        LottieHelper.hideAnimateion(lottieView: self.viewContainerLottie, in: self.viewLoadingOrError)
        self.collectionView.isHidden = false
        self.viewSuccess.isHidden = false
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
        return self.isUsingSearchBar ? self.moviesSearch.count : self.viewData.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieElementCollectionViewCell", for: indexPath) as? MovieElementCollectionViewCell else { return UICollectionViewCell() }
        let movie = self.isUsingSearchBar ? self.moviesSearch[indexPath.row] : self.viewData.movies[indexPath.row]
        cell.prepareCell(viewData: movie)
        return cell
    }
}

//MARK: - DELEGATE - UICollectionViewDelegate -
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.isUsingSearchBar ? self.moviesSearch[indexPath.row] : self.viewData.movies[indexPath.row]
        self.performSegue(withIdentifier: self.SEGUEDETAILMOVIE, sender: movie)
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

//MARK: - DELEGATE UISearchBarDelegate -
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.moviesSearch.removeAll()
        self.isUsingSearchBar = !searchText.isEmpty
        self.moviesSearch = self.viewData.movies.filter({$0.title.lowercased().contains(searchText.lowercased())})
        self.collectionView.reloadData()
        if self.moviesSearch.count == 0, self.isUsingSearchBar {
            self.showEmptyMessage()
        }else {
            self.hideEmptyMessage()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.moviesSearch.removeAll()
        self.searchBar.endEditing(true)
        self.isUsingSearchBar = false
        self.collectionView.reloadData()
        self.hideEmptyMessage()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.addGestureHideKeyBoard()
        if !self.viewLoadingOrError.isHidden {
            return false
        }
        return true
    }
    
    func showEmptyMessage() {
        self.labelError.isHidden = true
        LottieHelper.showAnimateion(for: .searchEmpty, lottieView: self.viewEmprySearch, in: self.viewEmprySearch)
        self.viewEmprySearch.loopMode = .autoReverse
        self.collectionView.isHidden = true
    }
    
    private func hideEmptyMessage() {
        LottieHelper.hideAnimateion(lottieView: self.viewEmprySearch, in: self.viewEmprySearch)
        self.collectionView.isHidden = false
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
    
    private func addGestureHideKeyBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyBoard))
        self.view.addGestureRecognizer(tap)
    }
}
