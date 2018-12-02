//
//  ViewController.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Alamofire

class MoviesViewController: UIViewController {
    
    var movies = [Movie]()
    let client = MovieAPIClient()
    private var currentPage = 2
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    // MARK: iOS Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        
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
        loadMovies(refresh: true)
    }
    
    private func loadMovies(refresh: Bool = false) {
        client.fetchPopularMovies(page: currentPage) { page in
            
            DispatchQueue.main.async {
                if refresh {
                    self.movies = page.results
                } else {
                    page.results.forEach { movie in
                        if !self.movies.contains(movie) {
                            self.movies.append(movie)
                        }
                    }
                    
                    self.moviesCollectionView.refreshControl?.endRefreshing()
                    self.moviesCollectionView.reloadData()
                }
                
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isCollectionViewAtTheEnd(indexPath) else { return }
        fetchNextPage()
    }
    
    private func isCollectionViewAtTheEnd(_ indexPath: IndexPath) -> Bool {
        return indexPath.row == self.movies.count - 1
    }
    
}

