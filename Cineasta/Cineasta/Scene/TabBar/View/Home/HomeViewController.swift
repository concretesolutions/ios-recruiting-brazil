//
//  HomeViewController.swift
//  CineastaNVActivityIndicatorView
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: - CONSTANTS -
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - VARIABLES -
    private var presenter: HomePresenter!
    private lazy var viewData = HomeViewData()
    private lazy var filteredMovies = [MovieViewData]()
    private lazy var loadingAnimation = AnimationView(name: "app_loading_animation")
    private var initialLoading = true
    private var loadingMovies = false
    
    // MARK: - IBACTIONS -
    @IBAction func reloadHome(_ sender: UIButton) {
        self.reload(sender)
    }
}

// MARK: - LIFE CYCLE -
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(viewDelegate: self)
        self.setupSearchBar()
        self.loadMovies()
    }
    
    override func viewWillLayoutSubviews() {
        self.removeSearchBarBottomLine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.removeSearchBarBottomLine()
        self.view.layoutIfNeeded()
        self.markAsFavoriteIfNeeded()
    }
}

// MARK: - PRESENTER -
extension HomeViewController: HomeViewDelegate {
    func setLoadingMovies(_ loading: Bool) {
        self.loadingMovies = true
    }
    
    func showMovies(viewData: HomeViewData) {
        self.viewData = viewData
        self.loadingMovies = false
        guard self.initialLoading else { self.homeTableView.reloadData(); return }
        self.hideLoadingViewAndShowMovies()
    }
    
    func showError() {
        self.changeAlpha(loadingView: 0, tableView: 0, emptyView: 0, errorView: 1)
    }
}

// MARK: - SEARCHBAR -
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.filteredMovies = self.viewData.movies.filter({
            return $0.title.lowercased().contains(searchText.lowercased())
        })
        if self.isFiltering() && self.filteredMovies.isEmpty {
            self.changeAlpha(loadingView: 0, tableView: 0, emptyView: 1, errorView: 0)
        } else {
            self.changeAlpha(loadingView: 0, tableView: 1, emptyView: 0, errorView: 0)
            self.homeTableView.reloadData()
        }
    }
}

// MARK: - TABLEVIEWDATASOURCE -
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering() ? self.filteredMovies.count : self.viewData.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNameID = Constants.Cells.movieTableViewCell
        tableView.register(UINib(nibName: cellNameID, bundle: nil), forCellReuseIdentifier: cellNameID)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNameID, for: indexPath) as! MovieTableViewCell
        let movieViewData = self.isFiltering() ? self.filteredMovies[indexPath.row] : self.viewData.movies[indexPath.row]
        cell.setupCell(viewData: movieViewData)
        return cell
    }
}

// MARK: - TABLEVIEWDELEGATE -
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewData.movies.count - 1,
            !self.loadingMovies,
            self.viewData.currentPage <= self.viewData.totalPages {
            self.presenter.getMovies(page: self.viewData.currentPage, reload: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.Segues.showMovieDetail, sender: indexPath.row)
    }
}

// MARK: - PREPARE FOR SEGUE -
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MovieDetailViewController,
            let anySender = sender, let index = anySender as? Int {
            viewController.viewData = self.isFiltering() ? self.filteredMovies[index] : self.viewData.movies[index]
        }
    }
}

// MARK: - AUX METHODS -
extension HomeViewController {
    private func setupSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "NOME DO FILME"
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.tintColor = .black
        self.searchController.searchBar.setValue("CANCELAR", forKey: "_cancelButtonText")
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    private func loadMovies() {
        self.initialLoading = true
        self.showLoadingView()
        self.presenter.getMovies(page: 1, reload: true)
    }
    
    private func showLoadingView() {
        self.changeAlpha(loadingView: 1, tableView: 0, emptyView: 0, errorView: 0)
        guard self.loadingView.subviews.isEmpty else { self.loadingAnimation.play(); return }
        self.loadingAnimation = AnimationView(name: "app_loading_animation")
        self.loadingAnimation.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.loadingAnimation.contentMode = .scaleAspectFit
        self.loadingAnimation.frame = self.loadingView.bounds
        self.loadingView.addSubview(self.loadingAnimation)
        self.loadingAnimation.loopMode = LottieLoopMode.loop
        self.loadingAnimation.play()
    }
    
    private func changeAlpha(loadingView: CGFloat, tableView: CGFloat, emptyView: CGFloat, errorView: CGFloat ) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.loadingView.alpha = loadingView
            self?.homeTableView.alpha = tableView
            self?.emptyView.alpha = emptyView
            self?.errorView.alpha = errorView
        })
    }
    
    private func removeSearchBarBottomLine() {
        guard let controller = self.navigationItem.searchController,
            let searchPalette = controller.searchBar.superview,
            let barBackGround = searchPalette.subviews.first,
            let backGroundImage = barBackGround.subviews.last as? UIImageView else { return }
        backGroundImage.backgroundColor = .white
    }
    
    private func markAsFavoriteIfNeeded() {
        guard !self.initialLoading,
            let result: [MovieViewData] = UserDefaulstHelper.shared.getObject(forKey: Constants.UserDefaultsKey.favoriteList) else { return }
        for (index, movie) in self.viewData.movies.enumerated() {
            self.viewData.movies[index].isFavorite = !result.filter({$0.movieId == movie.movieId}).isEmpty
        }
        self.homeTableView.reloadData()
    }
    
    private func hideLoadingViewAndShowMovies() {
        self.changeAlpha(loadingView: 0, tableView: 1, emptyView: 0, errorView: 0)
        self.loadingAnimation.stop()
        self.initialLoading = false
        self.homeTableView.reloadData()
    }
    
    private func reload(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: {
            sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }, completion: { [weak self] _ in
            self?.loadMovies()
        })
    }
    
    func isFiltering() -> Bool {
        return self.searchController.isActive && !self.searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
}
