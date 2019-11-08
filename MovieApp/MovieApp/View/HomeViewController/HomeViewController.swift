//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, FavoritableDelegate {
    let controller = MovieController()
    
    let collectionView: UICollectionView = {
        let colletion = UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout.init())
        colletion.backgroundColor = UIColor(red: 0.238, green: 0.271, blue: 0.331, alpha: 1.0)
        colletion.translatesAutoresizingMaskIntoConstraints = false
        return colletion
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.view.tintColor = .orange
        title = "Movies"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!,
             NSAttributedString.Key.foregroundColor: UIColor.orange]
        controller.delegate = self
        self.tabBarController?.delegate = self
        setupCollection()
        setupSearchBar()
        self.startAnimating()
        controller.getMovies()
        controller.getAllGenres()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
    
    func setupCollection() {
        view.addSubview(collectionView)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "qualquercoisa")
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if controller.getSearchActive() {
            return controller.getArrayFilterCount()
        }
        return controller.getArrayCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "qualquercoisa", for: indexPath) as? MovieCell else { return UICollectionViewCell()}
        if controller.getSearchActive() {
            let movie = controller.getMovieFilter(index: indexPath.item)
            cell.setupCell(movie: movie, index: indexPath.item, isFavorite: isInCoreData(movie: movie))
            cell.delegate = self
            return cell
        }
        let movie = controller.getMovie(index: indexPath.item)
        cell.setupCell(movie: movie, index: indexPath.item, isFavorite: isInCoreData(movie: movie))
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.movie = controller.getMovie(index: indexPath.item)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tagertContentOffSet = (collectionView.contentSize.height - collectionView.frame.height)
        if scrollView.contentOffset.y * 2 > tagertContentOffSet {
            controller.loadMoreMovies()
            self.startAnimating()
        }
    }
    
    
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        controller.filterMovies(name: searchString ?? "")
        collectionView.reloadData()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        controller.setSearchFalse()
        self.dismiss(animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        controller.setSearchTrue()
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        controller.setSearchTrue()
        collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !controller.getSearchActive() {
            controller.setSearchTrue()
            collectionView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    

    
}

extension HomeViewController: MovieControllerDelegate {
    func didFinishRequest() {
        collectionView.reloadData()
        self.stopAnimating()
        
    }
    
    func finishRefresh() {
        collectionView.reloadData()
        self.stopAnimating()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell: CGFloat = self.view.bounds.width/2 - 15
        return CGSize(width: widthCell, height: 1.5 * widthCell)
    }
}

extension HomeViewController: MovieCellDelegate {
    func tapped(index: Int) {
        save(movie: controller.getMovie(index: index))
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    
    
}
