//
//  MoviesController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher


class MoviesController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - Public Properties
    public var moc : NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                coreDataService = CoreDataService(moc: moc)
            }
        }
    }
    
    
    // MARK: - outlets
    @IBOutlet var errorHandlerView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
 
    
    // MARK: - Properties
    private var search = UISearchController(searchResultsController: nil)
    private var searchInProgress = false
    private var searchArgument = String()

    
    // Core Data -----------------------------------
    private var coreDataService : CoreDataService?
    // ---------------------------------------------
    
    private var movies = Movies()
    private var filteredMovies = Movies()
    private var isFiltering = false

    
    
    
    // pagination
    var pageCounter = 1
    var totalPages = 0
    var runningCall = false
    

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI Config
        uiConfig()
        
        // observers
        observerManager()
        
        // Check internet status
        checkInternetStatus()
        
        // load app data source
        loadPopularMovies(pageNumber: pageCounter)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // inactivate search on favorites controller to avoid black screen bug!!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "willInactivateFavoritesSearch"), object:self)
        // reload Data
        collectionView.reloadData()
    }

    

    // MARK: - UI Config
    private func uiConfig() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        // Navigation Search
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self // as? UISearchResultsUpdating
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search movies"
        search.searchBar.delegate = self
        search.searchBar.tintColor = UIColor.black
        
        // search text field background color
        if let textfield = search.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        // associate to navigation item
        self.navigationItem.searchController = search
        
    }
    
    // MARK: - Application Data Source
    private func loadPopularMovies(pageNumber: Int) {

        let webService = WebService()
        webService.getPopularMovies(page: pageNumber) { (moviesResults) in
            
            // total pages
            self.totalPages = moviesResults.total_pages
            
            // object movies
            self.movies.page = moviesResults.page
            self.movies.total_pages = moviesResults.total_pages
            self.movies.total_results = moviesResults.total_results
            
            
            // append results
            for item in moviesResults.results {
                self.movies.results.append(item)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            
            self.runningCall = false
            self.activityIndicatorShow(show: false)
            

        }
    }
    
    
    
    // MARK: - Observers
    private func observerManager() {
        
        removelAllObservers()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityStatusChanged(_:)),
                                               name: NSNotification.Name(rawValue: "ReachabilityChangedNotification"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willInactivateMoviesSearch(_:)),
                                               name: NSNotification.Name(rawValue: "willInactivateMoviesSearch"),
                                               object: nil)
    }
    
    private func removelAllObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachabilityChangedNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "willInactivateMoviesSearch"), object: nil)
    }
    
    // observer actions
    // rawValue: ReachabilityChangedNotification)
    @objc private func reachabilityStatusChanged(_ sender: NSNotification) {
        
        guard ((sender.object as? Reachability)?.currentReachabilityStatus) != nil else { return }
        
        checkInternetStatus()
        
    }
    
    @objc private func willInactivateMoviesSearch(_ sender: NSNotification) {
        self.search.isActive = false
    }
    
    private func checkInternetStatus() {
        if !reachability.isReachable() {
            AppSettings.standard.updateInternetConnectionStatus(false)
            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .internet, errorMessage: "Oops! Looks like you have no conection to the internet!")

        }else{
            AppSettings.standard.updateInternetConnectionStatus(true)
//            loadAppData()
            view.hideErrorView(view: view)
        }
    }

    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if AppSettings.standard.isConnectedToInternet {
            view.hideErrorView(view: self.errorHandlerView)
        }
    
        self.searchArgument = searchBar.text!.trimmingCharacters(in: .whitespaces)
        if self.searchArgument.isEmpty {
            return
        }
        
        
        self.filteredMovies.results = self.movies.results.filter { $0.title.lowercased().contains(self.searchArgument.lowercased())}
        self.isFiltering = true
        
        if filteredMovies.results.count == 0 {
            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .business, errorMessage: "No movie found with '\(searchBar.text!)'")
            return
        }
        
        // reload only the tableView
        DispatchQueue.main.async {
            self.collectionView.contentOffset = CGPoint.zero
            self.collectionView.reloadData()
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if AppSettings.standard.isConnectedToInternet {
            view.hideErrorView(view: self.errorHandlerView)
            collectionView.reloadData()
        }
    }
    
 
    func updateSearchResults(for searchController: UISearchController) {
        if !search.isActive {
            self.isFiltering = false
            self.searchArgument = String()
            self.pageCounter = 1
            self.totalPages = 0
            self.runningCall = false
            self.movies = Movies()
            self.loadPopularMovies(pageNumber: self.pageCounter)
        }
    }
    
    // MARK: - UICollectionView Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.isFiltering {
            return filteredMovies.results.count
        }else{
            return movies.results.count
        }
        
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MoviesCollectionCell
        var movie = movies.results[indexPath.row]
        
        // change provider in case of filtering
        if self.isFiltering {
            movie = filteredMovies.results[indexPath.row]
        }

        cell.movieTitle.text = movie.title


        
        if (self.coreDataService?.favoriteExists(id: String(movie.id)))! {
            cell.movieFavoriteBackgroundView.isHidden = false
        }else{
            cell.movieFavoriteBackgroundView.isHidden = true
        }

        // image
        if (!movie.poster_path.isEmpty && movie.poster_path != "" ) {
            
            let webService = WebService()
            let imgSrc = webService.getFullUrl(movie.poster_path)
            let url = URL(string: imgSrc)

            if imgSrc.isEmpty {
                cell.movieImageView?.contentMode = UIView.ContentMode.scaleAspectFill
                cell.movieImageView?.image = UIImage(named: "noContentIcon")

            }else{
                cell.movieImageView?.kf.indicatorType = .activity
                cell.movieImageView?.kf.setImage(with: url)
            }
            
        }else{
            cell.movieImageView?.contentMode = UIView.ContentMode.scaleAspectFill
            cell.movieImageView?.image = UIImage(named: "noContentIcon")
        }
        // end-image
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if movies.results.count == 0 {
            return
        }
        performSegue(withIdentifier: "showMovieDetail", sender: self)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            
            let indexPath = collectionView.indexPathsForSelectedItems?.first
            let cell = collectionView.cellForItem(at: indexPath!) as? MoviesCollectionCell
            
            let controller = segue.destination as! MovieDetailController
            controller.movie = movies.results[(indexPath?.row)!]
            controller.hidesBottomBarWhenPushed = true
            controller.movie = movies.results[(indexPath?.row)!]
            controller.movieImage = cell?.movieImageView.image ?? UIImage(named: "noContentIcon")!
            controller.moc = self.moc
            
        }
    }
    
    
    
    // MARK: - UIScrollView Delegate - Endless Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let bounds = scrollView.bounds;
        let size = scrollView.contentSize;
        let inset = scrollView.contentInset;
        let y = offsetY + bounds.size.height - inset.bottom;
        let h = size.height;
        
        // call your API for more data
        if (Int(y) == Int(h) && y > 100) {
            if !runningCall {
                runningCall = true
                if pageCounter < self.totalPages {
                    pageCounter = pageCounter + 1
                    
                    // filtering does not allow infinite pagination!
                    if !self.isFiltering {
                        activityIndicatorShow(show: true)
                        loadPopularMovies(pageNumber: pageCounter)
                    }
                    
                    
                }
                
            }
        }
    }
    
    // MARK: - Activity Indicator
    private func activityIndicatorShow(show: Bool){
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
}

