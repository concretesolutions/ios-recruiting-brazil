//
//  MovieGridCollectionViewController.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 17/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "MovieCell"

class MovieGridCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var errorView: UIView!
    var movies: [Movie]? = []
    var filteredMovies: [Movie] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var loadingMoviesActivityIndicator: UIActivityIndicatorView!
    var page = 1
    var isLoadingNextPage = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MovieGridCollectionViewController.handleRefresh(_:)),
                                 for: .valueChanged)
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        reload()
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        
        self.collectionView.addSubview(self.refreshControl)
        
        errorView.isHidden = true
        addActivityIndicator()
        loadPage(reload: false)
    }
    
    func setupSearchController() {
        offset = UIOffset(horizontal: (searchController.searchBar.frame.width - placeholderWidth) / 2, vertical: 0)
        searchController.searchBar.setPositionAdjustment(offset, for: .search)
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func reload() {
        page = 1
        loadPage(reload: true)
    }
    
    func loadPage(reload: Bool) {
        let client = TMDBClient()
        client.loadMovies(pageNumber: page) { (response, error) in
            guard response != nil else {
                DispatchQueue.main.async {
                    if self.page < response?.total_pages ?? 0 {
                        self.isLoadingNextPage = true
                    }
                    
                    self.loadingMoviesActivityIndicator.stopAnimating()
                    self.errorView.isHidden = false
                }
                
                return
            }
            
            let movies = response?.results?.map(Movie.init(movieResult:))
            if reload {
                self.movies = movies
            } else {
                self.movies! += movies ?? []
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.loadingMoviesActivityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // clears selection
        collectionView.reloadData()
    }
    
    func addActivityIndicator() {
        loadingMoviesActivityIndicator = UIActivityIndicatorView(style: .gray)
        loadingMoviesActivityIndicator.center = view.center
        loadingMoviesActivityIndicator.startAnimating()
        view.addSubview(loadingMoviesActivityIndicator)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! MovieDetailsTableViewController
        let indexPath = sender as! IndexPath
        destinationVC.movie = movies?[indexPath.row]
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
    
        // Configure the cell
        if let movie = movies?[indexPath.row] {
            cell.movieTitleLabel.text = movie.title
            
            if let movieId = movie.id, UserFavorites.shared.favorites.contains(movieId) {
                cell.favoriteIconImageView.image = UIImage(named: "favorite_full_icon")
            } else {
                cell.favoriteIconImageView.image = UIImage(named: "favorite_gray_icon")
            }
            
            if let posterPath = movie.posterPath {
                let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
                cell.moviePosterImageView.kf.indicatorType = .activity
                cell.moviePosterImageView.kf.setImage(with: imageURL)
            } else {
                cell.moviePosterImageView.image = nil
            }
            
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toMovieDetails", sender: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Screenshot cell width: 501, height: 618.
        // Screenshot device width: 1125, height: 2001.
        
        let widthPercentageOfScreen: CGFloat = 501 / 1125
        let cellWidth = self.collectionView.frame.width * widthPercentageOfScreen
        
        let heightPercentageOfScreen: CGFloat = 618 / 2001
        let cellHeight = self.collectionView.frame.height * heightPercentageOfScreen
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (movies?.count)! - 1 {
            page = page + 1
            loadPage(reload: false)
        }
    }

    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movies!.filter({( movie : Movie) -> Bool in
            return movie.title!.lowercased().contains(searchText.lowercased())
        })
        
        collectionView.reloadData()
    }
    
    let placeholderWidth: CGFloat = 130 // Replace with whatever value works for your placeholder text
    var offset = UIOffset()
}

extension MovieGridCollectionViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension MovieGridCollectionViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let noOffset = UIOffset(horizontal: 0, vertical: 0)
        searchBar.setPositionAdjustment(noOffset, for: .search)
        
        return true
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setPositionAdjustment(offset, for: .search)
        
        return true
    }
}
