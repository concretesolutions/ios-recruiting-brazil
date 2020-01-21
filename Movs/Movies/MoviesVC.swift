//
//  MoviesVC.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import SkeletonView
import CoreData

class MoviesVC: UIViewController {
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var page = 1
    var textSearched = ""
    var isSearchActive = false
    var loadingMovies = false
    var internetProblem = false
    var refreshControl = UIRefreshControl()
    
    var moviesDB: Movies!
    
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        setupRefresh()
        getPopularMoviesFromApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Movies"
        getPopularMoviesFromApi()
    }
    
    func getPopularMoviesFromApi() {
        self.loadingMovies = true
        if page == 1 {
            self.view.showAnimatedGradientSkeleton()
        }
        MovieDBApi.getPopularMovies(withPage: page, onComplete: { (movies) in
            self.movies.append(contentsOf: movies)
            self.view.stopSkeletonAnimation()
            self.view.hideSkeleton()
            self.page += 1
            self.loadingMovies = false
            self.internetProblem = false
            self.refreshControl.endRefreshing()
            self.moviesCollectionView.reloadData()
        }, onError: { (error) in
            self.internetProblem = true
            self.view.stopSkeletonAnimation()
            self.view.hideSkeleton()
            self.loadingMovies = false
            self.refreshControl.endRefreshing()
            self.moviesCollectionView.reloadData()
        })
    }
    func setupSearch() {
        self.searchBar.delegate = self
    }
    
    func setupRefresh(){
        self.moviesCollectionView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        moviesCollectionView.addSubview(refreshControl)
    }
    
    @objc func reload() {
        self.movies = [Movie]()
        self.filteredMovies = [Movie]()
        self.page = 1
        self.internetProblem = false
        moviesCollectionView.backgroundView?.isHidden = true
        getPopularMoviesFromApi()
        
    }
    
    func setBackgroundErrorView(withText text: String?, image: UIImage?, andCollectionView collectionView: UICollectionView) {
        let backgroundViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenericErrorVC")
        guard let myView = backgroundViewController.view as? GenericErrorView else { return }
        if let textContent = text {
            myView.genericErrorText.text = textContent
        }
        if let errorImage = image {
            myView.genericErrorImage.image = errorImage
        }
        collectionView.backgroundView = myView
        collectionView.backgroundView?.isHidden = false
    }
}
