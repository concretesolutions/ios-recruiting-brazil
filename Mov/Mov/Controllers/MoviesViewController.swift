//
//  ViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    let screen = MoviesViewControllerScreen()
    let searchController = UISearchController(searchResultsController: nil)

    
    
    override func loadView() {
        
        self.view = screen
        self.view.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.movieCollectionView.delegate = self
        screen.movieCollectionView.dataSource = self
        
        setupSearchController()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.backgroundColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        
        cell.title.text = "Thor"
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.435, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toMovieDetails()
    }
    
    func toMovieDetails() {
        let movieDetails = MovieDetailsViewController()
        movieDetails.view.backgroundColor = .white
        self.navigationController?.pushViewController(movieDetails, animated:
            true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

extension MoviesViewController: UISearchResultsUpdating {
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        // https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started
    }
}
