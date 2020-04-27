//
//  MoviesTableTableViewController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import RxSwift
import ReSwift

class PopularMoviesCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    let reuseIdentifier = "PopularMovieCell"
    
    var movies: [Movie] = []
    var genres: [Genre] = []
    
    var loading: Bool = false
    var error: String = ""
    
    var backgroundStateView: BackgroundStateView!
    
    let disposeBag = DisposeBag()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.backgroundStateView = BackgroundStateView()
        self.collectionView!.backgroundView = self.backgroundStateView;
        
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self) { $0.select(PopularMoviesViewModel.init) }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func retry() {
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopularMovieCollectionViewCell

        cell.setup(with: self.movies[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailsVC = MovieDetailsCollectionViewController(collectionViewLayout: StretchyHeaderLayout())
        let movie = movies[indexPath.row]
        movieDetailsVC.movieId = movie.id
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
}

extension PopularMoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.contentSize.width - 30) / 2
        return CGSize(width: size, height: size * (720 / 500) + 75)
    }
}


extension PopularMoviesCollectionViewController: StoreSubscriber {

    func newState(state: PopularMoviesViewModel) {
        
        if let backgroundViewConfiguration = state.backgroundViewConfiguration {
            backgroundStateView.showEmptyState(with: backgroundViewConfiguration)
        } else if state.loading {
            backgroundStateView.showLoading()
        } else {
            backgroundStateView.clear()
        }
        
        let shouldRefresh = self.movies != state.movies
        
        self.genres = state.genres
        self.movies = state.movies
        self.loading = state.loading
        
        if shouldRefresh {
            self.collectionView!.reloadData()
        }
    }
}
