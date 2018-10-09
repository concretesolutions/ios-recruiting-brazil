//
//  MoviesCollectionViewManager.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesCollectionViewManager: NSObject {
    
    private let collectionViewPadding: CGFloat = 10
    private var presenterProtocol: MoviesListPresenterProtocol?
    private var favIdList: [Int]?
        
    init(with presenter: MoviesListPresenterProtocol) {
        presenterProtocol = presenter
    }
}

//MARK: - CollectionView Delegate -
extension MoviesCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        let width = bounds.width/2 - (2*collectionViewPadding)
        let heightMultiplier = width / MovieCell.cellSize.width
        let height = MovieCell.cellSize.height * heightMultiplier
        
        return CGSize(width: width, height: height)
    }
}

//MARK: - CollectionView DataSource -
extension MoviesCollectionViewManager: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenterProtocol?.moviesLists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenterProtocol?.moviesLists?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movies = presenterProtocol?.moviesLists?[indexPath.section] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(with: MovieCell.self, for: indexPath)
        cell.delegate = self
        cell.model = movies[indexPath.item]
        return cell
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        let seventyPercent = scrollView.contentSize.height * 0.7
        if scrollPosition >= seventyPercent {
            presenterProtocol?.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenterProtocol?.openMovieDetail(to: indexPath)
    }
}

extension MoviesCollectionViewManager: MovieCellDelegate {
    func downloadImage(to model: MovieModel, completion: @escaping (ResponseResultType<Data>, String) -> Void) {
        presenterProtocol?.getMoviePoster(to: model, completion: completion)
    }
}
