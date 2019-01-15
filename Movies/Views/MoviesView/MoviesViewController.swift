//
//  MoviesViewController.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/9/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "movieCell"

class MoviesViewController: UICollectionViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var model: MoviesViewModel?
    var isLoadingData: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = MoviesViewModel(viewController: self)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Popular Movies"
        definesPresentationContext = true
        
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Popular"
        self.tabBarController?.navigationItem.searchController = searchController
    }

    // MARK: - Search bar functions
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = (model?.moviesArray.filter({( movie : MovieModel) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }))!
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isFiltering()){
            return filteredMovies.count
        }
        return model?.moviesArray.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MoviesCollectionViewCell else {
            fatalError("Not a category cell")
        }
        let movieToSetup: MovieModel?//model?.moviesArray[indexPath.row]
        if (isFiltering()) {
            movieToSetup = filteredMovies[indexPath.row]
        } else {
            movieToSetup = model?.moviesArray[indexPath.row]
        }
        
        if (!movieToSetup!.isThumbnailLoaded){
            model?.loadImage(forMovie: movieToSetup!, completion: { (newThumbnail) in
                movieToSetup?.thumbnail = newThumbnail
                movieToSetup?.isThumbnailLoaded = true
                cell.movieThumbnailImageView.image = newThumbnail
                cell.setupForMovie(Movie: movieToSetup!)
            })
        }
        
        cell.setupForMovie(Movie: movieToSetup!)
    
        return cell
    }

    //MARK: Request Delegate View Handling functions
    
    func didLoadPopularMovies() {
        self.collectionView.reloadData()
        self.loadingIndicator.stopAnimating()
        self.isLoadingData = false
    }
    
    func failedToLoad(withType type: String){
        let failAlert = UIAlertController(title: "Error", message: "Failed to load \(type). If this keeps happening, contact support.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        failAlert.addAction(defaultAction)
        self.present(failAlert, animated: true, completion: nil)
    }
    
    //MARK: Infinite Scroll
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        let diff = scrollContentSizeHeight - scrollOffset - scrollViewHeight    //This detects if the scroll is near the botom of the scroll view
        
        
        if (diff<30 && !isLoadingData)    //If the scroll is near the bottom, and there is no data being loaded, make a new request.
        {
            model?.requestMoreMovies()
            isLoadingData = true
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedCell = sender as! MoviesCollectionViewCell
        let selectedCellIndexPath = self.collectionView.indexPath(for: selectedCell)
        let selectedMovie = model!.moviesArray[selectedCellIndexPath!.row]
        
        let destinationViewController = segue.destination as! DetailsViewController
        destinationViewController.selectedMovie = selectedMovie
    }
}

extension MoviesViewController: UISearchResultsUpdating{
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
