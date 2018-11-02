//
//  ViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = CollectionViewDataSource()
    var pageCollection : Int = 1
    var sizeLastPage : Int = 0
    let activityIndicator = Activity.getActivityLoad(position: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2), hidesWhenStopped: true, style: UIActivityIndicatorView.Style.gray)
    let viewLoad = Load.getViewLoad(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), backGround: .gray, tag: 999)
    
    let searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
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
    
    //Mark: - Setups
    private func setupNavigation() {
        self.setupSearchController()
        self.navigationItem.title = "Movie"
        self.navigationController?.navigationBar.barTintColor = Colors.navigationController.value
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchResultsUpdater = self
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Pesquisa"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barTintColor = Colors.navigationController.value
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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
            self.setupStopLoading()
            if let _movies = moviesDonwloaded {
                self.pageCollection+=1
                self.sizeLastPage += ManagerMovies.shared.movies.count-1
                self.dataSource.datas = _movies
                self.collectionView.reloadData()
            }else {
                let viewNotFoundMovie = WarningScreens.coldNotDonwnloadMovies(message: "Error was ocurred, please try again tounch in button or try agray latter.", image: UIImageView(image: UIImage(named: "error")))
                viewNotFoundMovie.tag = 997
                self.view.addSubview(viewNotFoundMovie)
            }
        }
        dataSource.controller = self
    }
}

//MARK: - Delegates
extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DescriptionMovie", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "description") as? DescriptionMovieViewController
        vc?.movie = ManagerMovies.shared.movies[indexPath.row]
        if let descViewController = vc {
            self.navigationController?.pushViewController(descViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        if indexPath.row >= ManagerMovies.shared.movies.count-1 {
            self.setupLoad()
            setupCollectionView(page: pageCollection)
        }
    }
}

extension MoviesViewController: FavoriteDelegate {
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

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            let resultSearch = ManagerMovies.shared.movies.filter({$0.originalTitle.prefix(text.count) ==  text })
            let viewNotFoundMovie = WarningScreens.notFoundMovies(message: "coudn`t not find movies to:\(text)", image: UIImageView(image: UIImage(named: "search_icon")))
            viewNotFoundMovie.tag = 998
            
            if !text.isEmpty {
                if !resultSearch.isEmpty {
                        self.dataSource.datas = resultSearch
                        self.collectionView.reloadData()
                }else{
                    if self.view.viewWithTag(998) == nil {
                        self.view.addSubview(viewNotFoundMovie)
                    }
                }
            }else {
                self.view.viewWithTag(998)?.removeFromSuperview()
                self.dataSource.datas = ManagerMovies.shared.movies
                self.collectionView.reloadData()
            }
            
        }
    }
}
