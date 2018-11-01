//
//  ViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchBar = UISearchController()
    let dataSource = MoviesCollectionViewDataSource()
    var pageCollection : Int = 1
    var sizeLastPage : Int = 0
    
    let activityIndicator = Activity.getActivityLoad(position: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2), hidesWhenStopped: true, style: UIActivityIndicatorView.Style.gray)
    let viewLoad = Load.getViewLoad(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), backGround: .gray, tag: 999)
    let searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = false
        search.dimsBackgroundDuringPresentation = true
        search.searchBar.backgroundColor = Colors.navigationController.value
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLoad()
        setupCollectionView(page: pageCollection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dataSource.datas = ManagerMovies.shared.movies
        self.collectionView.reloadData()
    }
    
    //MARK: Privates Methods
    private func setupLoad() {
        self.view.addSubview(viewLoad)
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Movie"
        self.navigationController?.navigationBar.barTintColor = Colors.navigationController.value
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchResultsUpdater = self
    }
    
    private func setupStopLoading() {
        if let view = self.view.viewWithTag(999) {
            view.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupCollectionView(page: Int) {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        self.sizeLastPage += ManagerMovies.shared.movies.count-1
        ManagerMovies.shared.setupMovies(pageNumber: page) { (moviesDonwloaded) in
            if let _movies = moviesDonwloaded {
                self.dataSource.datas.append(contentsOf: _movies)
                self.setupStopLoading()
                self.collectionView.reloadData()
            }
        }
        dataSource.controller = self
    }
}

//MARK: - Delegates

extension MoviesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DescriptionMovie", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "description") as? DescriptionMovieViewController
        vc?.movie = ManagerMovies.shared.movies[indexPath.row]
        if let descViewController = vc {
            self.navigationController?.pushViewController(descViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        if indexPath.row == ManagerMovies.shared.movies.count-1 && ManagerMovies.shared.movies.count > self.sizeLastPage{
            print(ManagerMovies.shared.movies.count)
            pageCollection += 1
            self.setupLoad()
            setupCollectionView(page: pageCollection)
        }
    }
}

extension MoviesController: FavoriteMovieDelegate {
    func setFavorite(movie: MovieNowPlaying) {
        ManagerMovies.shared.moviesFavorites.append(movie)
        
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.movies)
        ManagerMovies.shared.movies[index].updateFavorite()
        self.dataSource.datas = ManagerMovies.shared.movies
        self.collectionView.reloadData()
    }
    
    func removeFavorite(movie: MovieNowPlaying) {
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.moviesFavorites)
        if  index != -1 {
            ManagerMovies.shared.moviesFavorites.remove(at: index)
        }
    }
}
extension MoviesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let resultSearch = ManagerMovies.shared.movies.filter({$0.originalTitle.prefix(searchText.count) ==  searchText })
        self.dataSource.datas = resultSearch
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dataSource.datas = ManagerMovies.shared.movies
        self.collectionView.reloadData()
        self.view.endEditing(true)
    }
}

extension MoviesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text {
            let resultSearch = ManagerMovies.shared.movies.filter({$0.originalTitle.prefix(text.count) ==  text })
            self.dataSource.datas = resultSearch
            self.collectionView.reloadData()
        }
        
    }
    
    
}
