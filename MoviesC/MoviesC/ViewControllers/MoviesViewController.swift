//
//  ViewController.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Alamofire
import Nuke

class MoviesViewController: UIViewController {
    
    var movies = [Movie]()
    private var currentPage = 1
    let client = MovieAPIClient()
    
    let preheater = ImagePreheater()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    // MARK: iOS Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.prefetchDataSource = self
        
        
        // UIRefreshControl setup
        moviesCollectionView.refreshControl = UIRefreshControl()
        moviesCollectionView.refreshControl?.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        moviesCollectionView.refreshControl?.beginRefreshing()
        loadMovies()
    }
    
    private func fetchNextPage() {
        currentPage += 1
        loadMovies()
    }
    
    @objc private func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    private func loadMovies(refresh: Bool = false) {
        client.fetchPopularMovies(page: currentPage) { response in
            
            switch response {
            case .success(let pagedResponse):
                self.moviesCollectionView.isHidden = false
                self.messageLabel.isHidden = true
                DispatchQueue.main.async {
                    if refresh {
                        self.movies = pagedResponse.results
                    } else {
                        pagedResponse.results.forEach { movie in
                            if !self.movies.contains(movie) {
                                self.movies.append(movie)
                            }
                        }
                    }
                    self.moviesCollectionView.refreshControl?.endRefreshing()
                    self.moviesCollectionView.reloadData()
                    
                }
            case .failure( _):
                self.moviesCollectionView.isHidden = true
                self.messageLabel.isHidden = false
            }
        }
    }
    
    
}

// MARK: UICollectionView Delegate and DataSource Methods


extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionCell
        cell.movie = movies[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        showMovie(at: indexPath)
    }
    
    func showMovie(at indexPath: IndexPath) {
        guard let movieVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieDetails") as? MovieDetailViewController else { fatalError("could not instantiate movies view controller") }
        guard let navigator = navigationController else {
            fatalError("navigation controller is nil")
        }
        
        movieVC.movie = movies[indexPath.row]
        navigator.pushViewController(movieVC, animated: true)
    }
    
    // MARK: Paging logic
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isPageAtTheEnd(indexPath) else { return }
        fetchNextPage()
    }
    
    private func isPageAtTheEnd(_ indexPath: IndexPath) -> Bool {
        return indexPath.row == self.movies.count - 1
    }
    
}

// MARK: Prefetching Methods

extension MoviesViewController: UICollectionViewDataSourcePrefetching {
    
    func imagesURLFor(indexPaths: [IndexPath]) -> [URL] {
        return indexPaths.compactMap { indexPath in
            guard indexPath.row < self.movies.count else { return nil }
            return self.movies[indexPath.row].posterUrl()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urlsToPreheat: [URL] = imagesURLFor(indexPaths: indexPaths)
        
        // Nuke's preheater manages all the image load requests. If a duplicate request is made, Nuke will not allow it and instead add another observer for the existing request.
        preheater.startPreheating(with: urlsToPreheat)
        
        // In case indexPaths are on the next page
        let needsFetch = indexPaths.contains { $0.row >= self.movies.count }
        if needsFetch {
            fetchNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        let urlsToStopPreheating: [URL] = imagesURLFor(indexPaths: indexPaths)
        preheater.stopPreheating(with: urlsToStopPreheating)
    }
    
}

