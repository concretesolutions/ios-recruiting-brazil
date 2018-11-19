//
//  MoviesController.swift
//  Movs
//
//  Created by Victor Rodrigues on 16/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit
import CoreData

class MoviesController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Properties
    lazy var searchController = UISearchController(searchResultsController: nil)
    var resultPopularMovies: Response?
    var moviesArr: [Response] = []
    var filtered: [Movie]?
    var favoritesDB = [Favorites]()
    var currentPage: Int = 0
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRequest()
        collectionView.reloadData()
        
    }
    
}

//MARK: Network
extension MoviesController {
   
    func loadMovies(page: Int) {
        if Reachability.isConnectedToNetwork() {
            
            let funcSucesso = { (item: Response?) -> Void  in
                if self.resultPopularMovies?.results == nil {
                    self.resultPopularMovies = item
                } else {
                    if let results = item!.results {
                        self.resultPopularMovies?.results = (self.resultPopularMovies?.results)! + results
                    }
                }
                
                self.fetchRequest()
                self.currentPage = item!.page!
            }
            
            let funcError = { (item: Response?) -> Void in
                
            }
            
            let funcNoConnection = { () -> Void in
                Activity.shared.stopProgress()
            }
            
            Network.shared.getPopularMovies(page: page, funcSucesso: funcSucesso, funcError: funcError, funcNoConnection: funcNoConnection)
            
        } else {
            let errorView = ErrorView()
            errorView.textMessage.text = "Internet Connection not Available!"
            errorView.imageView.image = UIImage(named: "sad")
            collectionView.backgroundView = errorView
        }
    }
    
}

//MARK: Functions
extension MoviesController {
    
    //MARK: Setup
    func setup() {
        setSearchBar()
        setCollection()
        
        AppDelegate.reachabilityStatus()
        Activity.shared.showProgress(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), message: "Loading...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            Activity.shared.stopProgress()
            self.loadMovies(page: 1)
        }
    }
    
    func setSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Cell.nibNameMovieCell, bundle: nil), forCellWithReuseIdentifier: Cell.identMovieCell)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: Screen.width() / 2 , height: 250 )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    //MARK: SearchBar
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if searchText != "" {
            filtered = resultPopularMovies?.results?.filter { item in
                return (item.title?.lowercased().contains(searchText.lowercased()))!
            }
        } else {
            filtered = resultPopularMovies?.results
        }
        collectionView.reloadData()
    }
    
    //MARK: CoreData
    func fetchRequest() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            favoritesDB = try CoreDataStack.managedObjectContext.fetch(fetchRequest) as! [Favorites]
        }catch{}
        collectionView.reloadData()
    }
    
}

//MARK: CollectionViewDelegate and DataSource
extension MoviesController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive {
            if self.filtered?.count == 0 {
                if let searchToSearch = searchController.searchBar.text {
                    let errorView = ErrorView()
                    errorView.imageView.image = UIImage(named: "searchIcon")
                    errorView.textMessage.text = "Your search for '\(searchToSearch)' no results were found."
                    self.collectionView.backgroundView = errorView
                }
            } else {
                self.collectionView.backgroundView = nil
            }
            return self.filtered!.count
        }
        else {
            guard let movies = resultPopularMovies?.results else {
                return 0
            }
            return movies.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identMovieCell, for: indexPath) as! CellMovie
        
        if searchController.isActive {
            if let f = filtered {
                cell.config(movies: f, at: indexPath.row)
            }
            
            let movieList = filtered?[indexPath.row]
            if let movies = resultPopularMovies?.results,
                let movieIndexId = movieList?.id {
                for movie in movies {
                    for favorite in favoritesDB {
                        if let movieId = movie.id {
                            if "\(movieId)" == favorite.id {
                                if movieId == movieIndexId {
                                    cell.isFavorited.image = UIImage(named: "favorited")
                                }
                            }
                        }
                    }
                }
            }
            
        } else {
            if let r = resultPopularMovies?.results {
                cell.config(movies: r, at: indexPath.row)
            }
            
            let movieList = resultPopularMovies?.results![indexPath.row]
            if let movies = resultPopularMovies?.results,
                let movieIndexId = movieList?.id {
                for movie in movies {
                    for favorite in favoritesDB {
                        if let movieId = movie.id {
                            if "\(movieId)" == favorite.id {
                                if movieId == movieIndexId {
                                    cell.isFavorited.image = UIImage(named: "favorited")
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        if indexPath.row == (resultPopularMovies?.results?.count)! - 1 {
            loadMovies(page: currentPage + 1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = resultPopularMovies?.results![indexPath.row]
        let vc = MoviesDetailController(nibName: "MoviesDetailController", bundle: nil)
        
        if let id = index?.id, let poster_path = index?.poster_path,
            let date = index?.release_date,
            let genre = index?.genre_ids,
            let title = index?.title,
            let overView = index?.overview,
            let idMovie = index?.id {
            vc.movieId = id
            vc.date = date
            vc.genreMovie = genre
            vc.titleMovie = title
            vc.overView = overView
            vc.imageUrl = poster_path
            vc.idMovie = "\(idMovie)"
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: UISearchResultsUpdating
extension MoviesController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}
