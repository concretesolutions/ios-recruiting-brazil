//
//  MoviesCollectionViewController.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 08/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import UIKit


class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MovieRequestListener {
    
    private let cellAspectRatio: CGFloat = 1.5
    private let maxCellsPerRow : CGFloat = 4.0
    private let cellMinWidth: CGFloat = 140.0
    private let minCellSpacing: CGFloat = 10.0
    private let cellSpacingPercent: CGFloat = 0.06
    
    private var movieCellSize = CGSize(width: 0.0, height: 0.0)
    
    private let infiteScrollReloadMargin = 4
    
    var moviesData: Array<MovieObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        self.collectionView.collectionViewLayout = layout
        self.updateLayout(layout)
        MovieRequestHandler.shared.requestMoviesFromScroll(listener: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let collectionViewLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            self.updateLayout(collectionViewLayout)
        }
    }
    
    func onRequestFromScrollFinished(_ fetchedMovies: Array<MovieObject>) {
        self.moviesData.append(contentsOf: fetchedMovies)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onImageRequestFinished(for movieObject: MovieObject) {
        if let movieIndex = movieObject.findIndex(in: self.moviesData) {
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(item: movieIndex, section: 0)])
            }
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

//DelegateFlowLayout
extension MoviesCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.movieCellSize
    }
}

//Delegate
extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item >= self.moviesData.count - self.infiteScrollReloadMargin) {
            MovieRequestHandler.shared.requestMoviesFromScroll(listener: self)
        }
    }
}

// DataSource
extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        movieCell.movie = self.moviesData[indexPath.item]
        return movieCell
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
