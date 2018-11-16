//
//  PopularMoviesViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    let contentLayoutData = ContentLayoutData()
    let indicatorOfActivity = UIActivityIndicatorView()
    var middle: PopularMoviesMiddle!
    var detailMiddle: MovieDetailMiddle!
    var movieDetailWorker: MovieDetailWorker!
    
    //MARK: - Super methods
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieDetailViewController
        //vc.middle.movieToLoad = sender as? MovieDetailWorker
        detailMiddle = MovieDetailMiddle(delegate: vc)
        vc.middle = detailMiddle
        self.detailMiddle.movieToLoad = sender as? MovieDetailWorker
        
    }
    
    //MARK: - METHODS
    
    func addActivityIndicator() {
        indicatorOfActivity.color = .black
        if popularMoviesCollectionView.isHidden == false {
            self.popularMoviesCollectionView.addSubview(indicatorOfActivity)
            self.indicatorOfActivity.isHidden = false
            indicatorOfActivity.translatesAutoresizingMaskIntoConstraints = false
            indicatorOfActivity.centerXAnchor.constraint(equalTo: self.popularMoviesCollectionView.centerXAnchor).isActive = true
            indicatorOfActivity.centerYAnchor.constraint(equalTo: self.popularMoviesCollectionView.centerYAnchor).isActive = true
            indicatorOfActivity.startAnimating()
        } else {
            self.view.addSubview(indicatorOfActivity)
            self.indicatorOfActivity.isHidden = false
            indicatorOfActivity.translatesAutoresizingMaskIntoConstraints = false
            indicatorOfActivity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            indicatorOfActivity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            indicatorOfActivity.startAnimating()
        }
        
    }
    
    func loadingError() {
        let alert = UIAlertController(title: "Ops!", message: "Verifique sua conexão e tente novamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tentar!", style: .default, handler: { _ in
            self.middle.isFetchInProgress = false
            if self.searchBar.text?.isEmpty == false {
                guard let searchText = self.searchBar.text else { return }
                self.middle.searchMovies(searchString: searchText)
            } else {
                self.middle.fetchMovies()
                self.popularMoviesCollectionView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { _ in
            self.middle.isFetchInProgress = false
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

//MARK: - COLLECTION VIEW DELEGATE

extension PopularMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.searchBar.text?.isEmpty == true {
            if indexPath.row == middle.popularResults.count - 1 {
                addActivityIndicator()
                middle.fetchMovies()
            }
        } else {
            if indexPath.row == middle.searchResultArray.count - 1 {
                addActivityIndicator()
                guard let searchString = searchBar.text else { return }
                middle.searchMovies(searchString: searchString)
            }
        }
    }
}

//MARK: - COLLECTION VIEW DATA SOURCE

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchBar.text?.isEmpty == true {
            let movie = middle.popularResults[indexPath.row]
            movieDetailWorker = MovieDetailWorker(posterPath: movie.poster_path, title: movie.title, genreID: movie.genre_ids, yearOfRelease: movie.release_date, isFavorite: false, description: movie.overview, id: movie.id)
            performSegue(withIdentifier: "movieDetail", sender: movieDetailWorker)
        } else {
            let movie = middle.searchResultArray[indexPath.row]
            movieDetailWorker = MovieDetailWorker(posterPath: movie.poster_path, title: movie.title, genreID: movie.genre_ids, yearOfRelease: movie.release_date, isFavorite: false, description: movie.overview, id: movie.id)
            performSegue(withIdentifier: "movieDetail", sender: movieDetailWorker)
        }
    }
}

//MARK: - MIDDLE DELEGATE

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
        popularMoviesCollectionView.isHidden = true
        indicatorOfActivity.removeFromSuperview()
        indicatorOfActivity.stopAnimating()
        self.loadingError()
    }
    
    func searchResultNil() {
        self.searchResulError()
    }
}

//MARK: - COLLECTION VIEW DELEGATE FLOW LAYOUT

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

//MARK: - SEARCH BAR DELEGATE

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.popularMoviesCollectionView.reloadData()
        middle.currentPage = 0
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
        middle.currentPage = 0
        middle.fetchMovies()
        popularMoviesCollectionView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
