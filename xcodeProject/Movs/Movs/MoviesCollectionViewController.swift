//
//  MoviesCollectionViewController.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 08/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import UIKit


class MoviesCollectionViewController: UICollectionViewController {
    private let movieSelectionSegue = "MovieSelectionSegue"
    
    private let cellAspectRatio: CGFloat = 1.5
    private let maxCellsPerRow : CGFloat = 4.0
    private let cellMinWidth: CGFloat = 140.0
    private let minCellSpacing: CGFloat = 10.0
    private let cellSpacingPercent: CGFloat = 0.06
    
    private var movieCellSize = CGSize(width: 0.0, height: 0.0)
    
    private let infiteScrollReloadMargin = 4
    
    var moviesData: Array<MovieObject> = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchApplied = false
    var movieRequestSearchInstance: MovieRequestHandler? = nil
    var filteredMovieData: Array<MovieObject> = []
    func visibleMovies() -> Array<MovieObject> {
        return self.searchApplied ? self.filteredMovieData : self.moviesData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.searchController.searchResultsUpdater = self
        //self.navigationItem.searchController = self.searchController
        
        let layout = UICollectionViewFlowLayout()
        self.collectionView.collectionViewLayout = layout
        self.updateLayout(layout)
        MovieRequestHandler.shared.requestMovies(listener: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let collectionViewLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            self.updateLayout(collectionViewLayout)
        }
    }
    
    func updateLayout(_ layout: UICollectionViewFlowLayout) {
        let collectionViewWidth = self.collectionView.frame.width
        let cellsPerRow = min(maxCellsPerRow, floor((collectionViewWidth - minCellSpacing) / (cellMinWidth + minCellSpacing)))
        let fullCellWidth = collectionViewWidth / cellsPerRow
        
        let cellSpacing = max(minCellSpacing, (fullCellWidth * cellSpacingPercent))
        let totalSpacing = cellSpacing * (cellsPerRow + 1.0)
        let spacingPerCell = totalSpacing / cellsPerRow
        
        let movieCellWidth = fullCellWidth - spacingPerCell
        self.movieCellSize = CGSize(width: movieCellWidth, height: movieCellWidth * self.cellAspectRatio)
        
        layout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        for cell in self.collectionView.visibleCells {
            if let movieCell = cell as? MovieCollectionViewCell {
                movieCell.onCollectionViewLayoutUpdate(cellSize: self.movieCellSize)
            }
        }
    }
}

extension MoviesCollectionViewController: MovieRequestListener {
    func onMoviesRequestFinished(_ fetchedMovies: Array<MovieObject>) {
        self.moviesData.append(contentsOf: fetchedMovies)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onMoviesRequestFinished(_ fetchedMovies: Array<MovieObject>, withSearchTerm searchTerm: String) {
        DispatchQueue.main.async {
            if self.searchController.searchBar.text == searchTerm {
                let newData = fetchedMovies.filter { movieObject in
                    return movieObject.findIndex(in: self.moviesData) == nil
                }
                self.filteredMovieData.append(contentsOf: newData)
                self.moviesData.append(contentsOf: newData)
                self.collectionView.reloadData()
            }
        }
    }
    
    func onImageRequestFinished(for movieObject: MovieObject) {
        if let movieIndex = movieObject.findIndex(in: self.visibleMovies()) {
            DispatchQueue.main.async {                
                self.collectionView.reloadItems(at: [IndexPath(item: movieIndex, section: 0)])
            }
        }
    }
}

extension MoviesCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = self.searchController.searchBar.text, !searchTerm.isEmpty {
            self.searchApplied = true
            self.filteredMovieData = self.moviesData.filter { movieObject -> Bool in
                return movieObject.title.lowercased().contains(searchTerm.lowercased())
            }
            self.movieRequestSearchInstance = MovieRequestHandler.createSearchInstance(forTerm: searchTerm)
            self.movieRequestSearchInstance?.requestMovies(listener: self)
        }
        else {
            self.searchApplied = false
            self.movieRequestSearchInstance = nil
            self.filteredMovieData = []
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.movieCellSize
    }
}

//Delegate
extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item >= self.visibleMovies().count - self.infiteScrollReloadMargin) {
            if self.searchApplied {
                self.movieRequestSearchInstance?.requestMovies(listener: self)
            } else {
                MovieRequestHandler.shared.requestMovies(listener: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == movieSelectionSegue {
            if let movieDetailVC = segue.destination as? MovieDetailViewController, let movieObject = sender as? MovieObject {
                movieDetailVC.movieObject = movieObject
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieCell = self.collectionView(collectionView, cellForItemAt: indexPath) as? MovieCollectionViewCell {
            performSegue(withIdentifier: movieSelectionSegue, sender: movieCell.movie)
        }
    }
}

// DataSource
extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.visibleMovies().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        movieCell.movie = self.visibleMovies()[indexPath.item]
        return movieCell
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
