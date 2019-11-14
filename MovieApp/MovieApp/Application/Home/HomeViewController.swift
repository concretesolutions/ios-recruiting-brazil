//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit


class HomeViewController: BaseViewController {
    
    private lazy var controller = HomeController(delegate: self)
    
    let collectionView: UICollectionView = {
        let colletion = UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        colletion.backgroundColor = .background
        colletion.translatesAutoresizingMaskIntoConstraints = false
        colletion.collectionViewLayout = layout
        colletion.showsVerticalScrollIndicator = false
        colletion.showsHorizontalScrollIndicator = false
        return colletion
    }()
    
    private lazy var dataSource = MovieCollectionDataSource(collectionView: self.collectionView, delegate: self)

    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        return searchController

    }()
    
    private var searchDataSource: MovieSearchBarDataSource?

    override func loadView() {
        super.loadView()
        setupView()
        setupLayout()
        controller.getAllGenres()
        controller.getMovies()
        setupSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    private func setupView() {
        self.navigationController?.view.tintColor = .orange
        title = Strings.titleHome
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Strings.fontProject, size: 30)!,
             NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        self.tabBarController?.delegate = self
        self.startAnimating()
    }
    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupSearch() {
        searchDataSource = MovieSearchBarDataSource(searchController: searchController, delegate: self)
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
}

extension HomeViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            self.collectionView.setContentOffset(CGPoint(x: 0, y: -100), animated: true)
        }
    }
}

extension HomeViewController: MovieDataSourceDelegate {
    
    func didSelected(movie: Movie) {
        let viewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func favoriteMovie(movie: Movie) {
        controller.saveMovie(movie: movie)
        collectionView.reloadData()
    }
    
    func didScroll() {
        controller.getMovies()
    }
    
}

extension HomeViewController: HomeControllerDelegate {
    
    func showMovies(movies: [Movie]) {
        dataSource.updateMovies(movies: movies)
    }

    func error(type: TypeError) {
        addError(type: type)
    }
}

extension HomeViewController: MovieSearchBarDataSourceDelegate {
    
    func updateSearchResult(text: String) {
        controller.filterMovies(text: text)
    }
    
    func cancelButton() {
        self.dismiss(animated: true)
    }
    

}
