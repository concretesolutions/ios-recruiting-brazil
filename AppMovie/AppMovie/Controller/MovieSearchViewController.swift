//
//  MovieSearchViewController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    //Mark: - Properties
    @IBOutlet weak var movieSearch: UISearchBar!
    @IBOutlet weak var movieCollection: UICollectionView!
    
    var movie = [Result]()
    //For system of search
    var filteredMovie = [Result]()
    var inSearchMode = false
    
    var isLoading = false
    var pageCount: Int = 1
    var totalPages: Int = 46
    
    var collectionViewDataSource: MovieSearchCollectionViewDataSource?
    var collectionViewDelegate: MovieSearchCollectionViewDelegate?
    
    //Mark: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        api()
    }
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Movies"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.mainColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.tintColor = UIColor.mainDarkBlue()
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainDarkBlue(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        //
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //TODO: left bar button
        //        let rightButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "IconFilter"), style: .plain, target: self, action: #selector(self.actionFilter(sender:)))
        //        self.navigationItem.rightBarButtonItem = rightButton
        
        
        //Search
        movieSearch.barTintColor = UIColor.mainColor()
        movieSearch.tintColor = UIColor.mainOrange()
        movieSearch.showsCancelButton = false
        for v:UIView in movieSearch.subviews.first!.subviews {
            if v.isKind(of: UITextField.classForCoder()) {
                (v as! UITextField).tintColor = UIColor.white
                (v as! UITextField).backgroundColor = UIColor.mainOrange()
            }
        }
    }
    
    // MARK: - SETUP COLLECTIONVIEW
    func setupCollectionView(with movies: [Result]){
        collectionViewDataSource = MovieSearchCollectionViewDataSource(movies: movies, collectionView: movieCollection, delegate: self)
        collectionViewDelegate = MovieSearchCollectionViewDelegate(movies: movies, delegate: self)
        
        movieCollection.dataSource = collectionViewDataSource
        movieCollection.delegate = collectionViewDelegate
        movieCollection.reloadData()
    }
    
    // MARK: - API
    func api(){
        MovieServices.instance.getMovies(page: pageCount){ [weak self] movies in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.movie = movies
                self.setupCollectionView(with: self.movie)
            }
        }
    }
}

// MARK: - Protocol Delegate DidSelect
extension MovieSearchViewController: MovieSelectionDelegate{
    func didSelect(movie: Result) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("should be a controller of type MovieDetailViewController")
        }
        
        controller.movieCell = movie
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Protocol Delegate Paging
extension MovieSearchViewController: MoviePagingDelegate{
    func loadMovies() {
        print("LoadMovies")
        pageCount += 1
        print(pageCount)
        MovieServices.instance.getMovies(page: pageCount){ [weak self] movies in
            guard let self = self else { return }
            self.isLoading = false
            print(movies)
            DispatchQueue.main.async {
                self.movie += movies
                self.setupCollectionView(with: self.movie)
            }
        }
    }
}

// MARK: - UISearchDelate
extension MovieSearchViewController: UISearchBarDelegate{
    
}
