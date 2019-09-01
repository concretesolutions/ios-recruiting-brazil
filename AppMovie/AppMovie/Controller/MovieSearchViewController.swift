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
        api()
        configureViewComponents()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupCollectionView(with: self.movie)
    }
    
    /*SetupView Inject Dependence(MOCKS...)
     func setupView(service: MovieService){
     self.service = service
     }*/
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Movies"
        self.tabBarController?.tabBar.isHidden = false
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
        let checkedMovies = checkIsFavoriteMovie(movies: movies)
        collectionViewDataSource = MovieSearchCollectionViewDataSource(movies: checkedMovies, collectionView: movieCollection, delegate: self)
        collectionViewDelegate = MovieSearchCollectionViewDelegate(movies: checkedMovies, delegate: self)
        
        movieCollection.dataSource = collectionViewDataSource
        movieCollection.delegate = collectionViewDelegate
        movieCollection.reloadData()
    }
    
    // MARK - Verify FROM  Coredata  IS FAVORITE
    func checkIsFavoriteMovie(movies: [Result]) -> [Result] {
        /// favoriteMovies.removeAll()/
        var checkedMovies = movies
        let manegerCoreData = ManegerCoreData()
        
        for i in 0..<checkedMovies.count {
            let isFavorite = manegerCoreData.checkFavoriteMovie(movieId: "\(checkedMovies[i].id)")
            if (isFavorite == true){
                checkedMovies[i].setIsFavorite()}
            print("ValidaCore\(isFavorite)")
        }
        return checkedMovies
    }
    
    // MARK: - API Services
    func api(){
        service.getMovies(page: pageCount){ [weak self] movies in
            guard let self = self else { return }
            self.movie.append(contentsOf: movies)
            DispatchQueue.main.async {
                self.setupCollectionView(with: self.movie)
            }
        }
    }
    
    func apiWithQuery(query: String){
        service.getMoviesByQuery(query: query){ [weak self] movies in
            guard let self = self else { return }
            self.isLoading = false
            DispatchQueue.main.async {
                self.filteredMovie += movies
                if(movies.isEmpty){
                    self.EmptyTextField(text: "Not Found", message: "Filme não encontrado na lista de filmes Populares")
                     self.setupCollectionView(with: self.movie)
                    return
                }
                self.setupCollectionView(with: self.filteredMovie)
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
        if !query.isEmpty {
            print(query)
            apiWithQuery(query: query)
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
