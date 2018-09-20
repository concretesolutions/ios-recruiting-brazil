//
//  PopularMoviesViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class PopularMoviesViewController: BaseViewController {
    
    /// The list of movies
    private var movies:[Movie] = []
    
    // Controls if the list is loading more items
    var isLoadingMore = false
    
    // Controls the Scroll's last position
    var lastOffset: CGFloat = 0.0
    
    // Indicates the current list page
    var currentPage = 1
    
    // Indicates if it's the first time loading the app
    var firstTime = true
    
    private unowned var popularMoviesView: PopularMoviesView{ return self.view as! PopularMoviesView }
    
    private unowned var collectionView:UICollectionView { return popularMoviesView.collectionView }
    private unowned var refreshControl:UIRefreshControl { return popularMoviesView.refreshControl }

    override func loadView() {
        self.view = PopularMoviesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController(navBarTitle: "Popular Movies")
        setupBarsTableView()
        
        showLoading()
        requestPopularMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !firstTime{
            updateList()
        }
        firstTime = false
    }
    
    /// Updates the state of the list
    private func updateList(){
        collectionView.reloadData()
        if movies.isEmpty{
            self.showFeedback(message: "Ops... Something went wrong. Please, try again.")
        }
        else if filteredMovies.isEmpty{
            self.showFeedback(message: "There is no movies with the search term you typed.")
        }
        else{
            self.showFeedback()
        }
    }
    
    /// Sets up the collectionView
    private func setupBarsTableView(){
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        collectionView.contentOffset = CGPoint(x:0, y:-refreshControl.frame.size.height)
    }
    
    @objc private func refreshAction(){
        currentPage = 1
        showFeedback()
        requestPopularMovies()
    }
    
    /// Makes the request to the list of popular movies
    private func requestPopularMovies(page:Int=1){
        RequestMovie().list(page: page).responseJSON { response in
            
            if page == 1{
                self.movies = []
            }

            if let data = response.data, let result = try? JSONDecoder().decode(Result.self, from: data), let movies = result.movies{
                self.movies.append(contentsOf: movies)
            }
            
            self.showLoading(false)
            self.refreshControl.endRefreshing()
            
            self.collectionView.reloadData()
            self.isLoadingMore = false
            
            self.filteredMovies = self.movies
            self.updateList()
        }
    }
    
    /// Makes the request to the list of popular movies based on a search term
    private var isSearching = false
    private func searchMovie(term:String?){
        RequestMovie().search(term).responseJSON { response in
            
            self.filteredMovies = []
            if let data = response.data, let result = try? JSONDecoder().decode(Result.self, from: data), let movies = result.movies{
                self.filteredMovies.append(contentsOf: movies)
            }
            
            self.showLoading(false)
            self.refreshControl.endRefreshing()
            
            self.collectionView.reloadData()
            self.isLoadingMore = false
            
            self.updateList()
        }
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        triggerRequestForText(searchController.searchBar.text)
    }
    
    /// Triggers the timer to execute the filtering
    private func triggerRequestForText(_ term:String?){
        timer?.invalidate()
        if let text = term, !text.isEmpty {
            isSearching = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                print("Filtering movie with name: \(text)...")
                self.searchMovie(term: text)
            }
        }
        else{
             isSearching = false
             requestPopularMovies()
        }
    }
}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width/2.15, height: 270)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else{
            return UICollectionViewCell()
        }
        cell.setupCell(movie: filteredMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController   = DetailMovieViewController()
        detailController.movie = filteredMovies[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

/// Delegates for Scrolling
extension PopularMoviesViewController{
    
    // Load more items when the collectionView's scrolls reach
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationItem.searchController?.searchBar.endEditing(true)
        if scrollView == self.collectionView && !isSearching{
            
            let contentOffset = scrollView .contentOffset.y
            let maximumOffset = (scrollView.contentSize.height - scrollView.frame.size.height)
            
            // Checks if it is the end of the scroll
            if(contentOffset >= maximumOffset){
                
                if(!isLoadingMore){
                    isLoadingMore = true
                    currentPage   = currentPage + 1
                    
                    requestPopularMovies(page: currentPage)
                    print("Loading more movies from page \(currentPage)...")
                }
            }
        }
    }
}
