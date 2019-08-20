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
    
    var service: MovieService = MovieServiceImpl()
    
    //Mark: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        api()
        setupSearchBar()
    }
    
    /*SetupView Inject Dependence(MOCKS...)
     func setupView(service: MovieService){
     self.service = service
     }*/
    
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
        
        
        //Search
        movieSearch.barTintColor = UIColor.mainColor()
        movieSearch.tintColor = UIColor.mainDarkBlue()
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
        service.getMovies(page: pageCount){ [weak self] movies in
            guard let self = self else { return }
            self.movie += movies
            DispatchQueue.main.async {
                self.setupCollectionView(with: self.movie)
            }
        }
    }
}

// MARK: - Protocol MOVIE SELECTION DELEGATE
extension MovieSearchViewController: MovieSelectionDelegate{
    func didSelect(movie: Result) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("should be a controller of type MovieDetailViewController")
        }
        
        controller.movieCell = movie
        navigationController?.pushViewController(controller, animated: true)
    }
    func removeMovie(atIndexPath: IndexPath) {}
}

// MARK: - Protocol Delegate Paging
extension MovieSearchViewController: MoviePagingDelegate{
    func loadMovies() {
        print("LoadMovies")
        pageCount += 1
        print(pageCount)
        if (inSearchMode == false){
//            service.getMovies(page: pageCount){ [weak self] movies in
//                guard let self = self else { return }
//                self.isLoading = false
//                print(movies)
//                DispatchQueue.main.async {
//                    self.movie += movies
//                    self.setupCollectionView(with: self.movie)
//                }
//            }
            api()
        }
    }
}

// MARK: - UISearchDelate
extension MovieSearchViewController: UISearchBarDelegate{
    func setupSearchBar() {
        self.movieSearch.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieSearch.resignFirstResponder()
        let query = searchBar.text ?? ""
        print(searchBar.text)
        if !query.isEmpty {
            print(query)
            service.getMoviesByQuery(query: query){ [weak self] movies in
                guard let self = self else { return }
                self.isLoading = false
                print(movies)
                DispatchQueue.main.async {
                    self.filteredMovie += movies
                    self.setupCollectionView(with: self.filteredMovie)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        movieSearch.showsCancelButton = false
        print("Cancel")
        self.setupCollectionView(with: self.movie)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            inSearchMode = false
            self.setupCollectionView(with: self.movie)
        } else {
            movieSearch.showsCancelButton = true
            inSearchMode = true
            print(searchText)
            filteredMovie = movie.filter({ $0.title?.lowercased().range(of: searchText.lowercased()) != nil })
            //filter({$0.title.lowercased().contains(searchText.lowercased())})
            print(filteredMovie)
            self.setupCollectionView(with: self.filteredMovie)
        }
    }
    
}
