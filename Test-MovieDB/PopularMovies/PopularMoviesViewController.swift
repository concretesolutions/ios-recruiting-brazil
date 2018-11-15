//
//  PopularMoviesViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    //@IBOutlet weak var indicatorOfActivity: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    let contentLayoutData = ContentLayoutData()
    let indicatorOfActivity = UIActivityIndicatorView()
    
    var middle: PopularMoviesMiddle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularMoviesCollectionView.delegate = self
        popularMoviesCollectionView.dataSource = self
        searchBar.delegate = self
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.barTintColor = Colors.yellowNavigation.color
        searchBar.barTintColor = Colors.yellowNavigation.color
        let tf = searchBar.value(forKey: "searchField") as! UITextField
        tf.backgroundColor = Colors.darkYellow.color
        tf.placeholder = "Search"
        
        tabBarController?.tabBar.barTintColor = Colors.yellowNavigation.color
        
        popularMoviesCollectionView.isHidden = true
        
        addActivityIndicator()
        
        indicatorOfActivity.startAnimating()
        
        middle = PopularMoviesMiddle(delegate: self)
        middle.fetchMovies()
        
    }
    
    func addActivityIndicator() {
        self.popularMoviesCollectionView.addSubview(indicatorOfActivity)
        indicatorOfActivity.translatesAutoresizingMaskIntoConstraints = false
        indicatorOfActivity.centerXAnchor.constraint(equalTo: self.popularMoviesCollectionView.centerXAnchor).isActive = true
        indicatorOfActivity.centerYAnchor.constraint(equalTo: self.popularMoviesCollectionView.centerYAnchor).isActive = true
        indicatorOfActivity.startAnimating()
    }
    
    func loadingError() {
        let alert = UIAlertController(title: "Ops!", message: "Ocorreu um erro, tente novamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tentar!", style: .default, handler: { _ in
            guard let searchText = self.searchBar.text else { return }
            self.middle.searchMovies(searchString: searchText)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { _ in
            self.middle.fetchMovies()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchResulError() {
        let alert = UIAlertController(title: "Ops!", message: "Sua busca não resultou em nenhum resultado.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= middle.currentPage
    }
    
    func visibleIndexPathsToReload(paths: [IndexPath]) -> [IndexPath] {
        let indexPathsOfVisibleRows = popularMoviesCollectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsOfVisibleRows).intersection(paths)
        return Array(indexPathsIntersection)
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.searchBar.text?.isEmpty == true {
            if indexPath.row == middle.popularResults.count - 1 {
                addActivityIndicator()
                middle.fetchMovies()
            }
        } else {
            if indexPath.row == middle.popularResults.count - 1 {
                addActivityIndicator()
                guard let searchString = searchBar.text else { return }
                middle.searchMovies(searchString: searchString)
            }
        }
    }
}

extension PopularMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBar.text?.isEmpty == true {
            return middle.popularResults.count
        } else {
            return middle.searchResultArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popular", for: indexPath) as! PopularMoviesCollectionViewCell
        if self.searchBar.text?.isEmpty == false {
            cell.configure(with: nil, searchData: middle.searchData(at: indexPath.row))
        } else {
            cell.configure(with: middle.movieData(at: indexPath.row), searchData: nil)
        }
        cell.backgroundColor = .black
        return cell
    }
}

extension PopularMoviesViewController: PopularMoviesMiddleDelegate {
    
    func fetchCompleted() {
        popularMoviesCollectionView.isHidden = false
        indicatorOfActivity.stopAnimating()
        indicatorOfActivity.removeFromSuperview()
        popularMoviesCollectionView.reloadData()
    }
    
    func fetchWithNewPageResults(paths: [IndexPath]) {
        popularMoviesCollectionView.isHidden = false
        indicatorOfActivity.removeFromSuperview()
       indicatorOfActivity.stopAnimating()
        let pathsToReload = visibleIndexPathsToReload(paths: paths)
        popularMoviesCollectionView.reloadData()
        popularMoviesCollectionView.reloadItems(at: pathsToReload)
    }
    
    func fetchFailed() {
        popularMoviesCollectionView.removeFromSuperview()
        indicatorOfActivity.removeFromSuperview()
        indicatorOfActivity.stopAnimating()
        self.loadingError()
    }
    
    func searchResultNil() {
        self.searchResulError()
    }
}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height2 = collectionView.frame.height * 0.45
        let width2 = (collectionView.frame.width * 0.5) - contentLayoutData.leftEdgeInsetConstant - contentLayoutData.rightEdgeInsetConstant
        
        return CGSize(width: width2, height: height2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: contentLayoutData.topEdgeInsetConstant, left: contentLayoutData.leftEdgeInsetConstant, bottom: contentLayoutData.bottomEdgeInsetConstant, right: contentLayoutData.rightEdgeInsetConstant)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return contentLayoutData.spaceBetweenItemsConstant
    }
    
}

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.popularMoviesCollectionView.reloadData()
        if searchText.isEmpty {
            self.middle.fetchMovies()
        }
        self.middle.searchResultArray.removeAll(keepingCapacity: true)
        self.popularMoviesCollectionView.isHidden = true
        self.addActivityIndicator()
        self.middle.searchMovies(searchString: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let textOfSearchBar = searchBar.text else { return }
        if searchBar.text?.isEmpty == true {
            self.middle.fetchMovies()
            
        }
        self.middle.searchMovies(searchString: textOfSearchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        middle.fetchMovies()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
}
