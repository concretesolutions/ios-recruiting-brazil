//
//  MoviesController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    

    // MARK: - outlets
    @IBOutlet var errorHandlerView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
 
    
    // MARK: - Properties
    private var search = UISearchController()
    private var searchInProgress = false
    private var searchArgument = String()
    
    private var movies = Movies()
    private var filteredMovies = Movies()
    
    
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
    

    

    // MARK: - UI Config
    private func uiConfig() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        // Navigation Search
        search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchResultsUpdater = self as? UISearchResultsUpdating
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
        
        //
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityStatusChanged(_:)),
                                               name: NSNotification.Name(rawValue: "ReachabilityChangedNotification"),
                                               object: nil)
        
        
        
    }
    
    // observer actions
    // rawValue: ReachabilityChangedNotification)
    @objc private func reachabilityStatusChanged(_ sender: NSNotification) {
        
        guard ((sender.object as? Reachability)?.currentReachabilityStatus) != nil else { return }
        
        checkInternetStatus()
        
    }
    
    private func checkInternetStatus() {
        if !reachability.isReachable() {
            AppSettings.standard.updateInternetConnectionStatus(false)
            
            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .internet, errorMessage: "Oops! Looks like you have no conection to the internet!")
            
//            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .business, errorMessage: "Search argument not found!")
            
//            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .loading, errorMessage: "Loading...")
            
        }else{
            AppSettings.standard.updateInternetConnectionStatus(true)
            
//            loadAppData()
            
            view.hideErrorView(view: view)
            
            // post notification to error hanlder to dismiss UI
//            NotificationCenter.default.post(name: Notification.Name("didConnectToInternet"), object: nil, userInfo: nil)
        }
    }

    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchArgument = searchBar.text!.trimmingCharacters(in: .whitespaces)
        
        print("**** SEARCH ARGUMENT : \(self.searchArgument)")
//        let trimmedString = " abc ".trimmingCharacters(in: .whitespaces)
        
        
        self.filteredMovies.results = self.movies.results.filter {
            $0.title == self.searchArgument
        }
        print("CHECK FILTERED RESULTS")
        
//        self.search.setEditing(true, animated: true)
//        self.searchInProgress = true
//        self.searchArgument = (searchBar.text?.trim())!
//        //
//        navigationController?.navigationBar.isHidden = true
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = false
//        } else {
//            // Fallback on earlier versions
//        }
//        self.search.isActive = false
//        //
//
//        self.performSegue(withIdentifier: "showSearchScene", sender: self)
//
//    }
    
//    @objc private func didSelectBarBackAction() {
//
//        // reinstantiate scene
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController()
//        UIApplication.shared.keyWindow?.rootViewController = vc
//
//
    }
 
    
    // MARK: - UICollectionView Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.results.count
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MoviesCollectionCell
        let movie = movies.results[indexPath.row]

        
        cell.movieTitle.text = movie.title
        cell.movieFavoriteBackgroundView.isHidden = false
        
        // image
        if (!movie.poster_path.isEmpty && movie.poster_path != "" ) {
            
            let webService = WebService()
            let imgSrc = webService.getFullUrl((movie.poster_path))
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
                    print("🌕 READ MORE....... pageNumber: \(pageCounter)")
                    activityIndicatorShow(show: true)
                    loadPopularMovies(pageNumber: pageCounter)
                }
                
            }
        }
    }
    
    // MARK: - Activity Indicator
    private func activityIndicatorShow(show: Bool){
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
}

