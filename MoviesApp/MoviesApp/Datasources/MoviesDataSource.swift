//
//  MoviesDataSource.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

final class MoviesDataSource:NSObject{
    
    var service = MoviesServiceImplementation()
    var movies:[Movie] = []{
        didSet{
            delegate?.movies = movies
        }
    }
    var currentPage = 1
    var totalResults:Int
    
    
    weak var collectionView:UICollectionView?
    weak var delegate:MoviesCollectionDelegate?
    
    required init(movies: [Movie], totalResults:Int, collectionView:UICollectionView, delegate:MoviesCollectionDelegate) {
        self.movies = movies
        self.collectionView = collectionView
        self.delegate = delegate
        self.totalResults = totalResults
        super.init()
        self.collectionView?.register(cellType: MovieCollectionViewCell.self)
        self.collectionView?.dataSource = self
        self.collectionView?.prefetchDataSource = self
        self.collectionView?.delegate = delegate
        self.collectionView?.reloadData()
        
    }
    
    func updateMovies(_ movies:[Movie]){
        self.movies = movies
        self.collectionView?.reloadData()
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
        let startIndex = movies.count - movies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func fetchNextPage(){
        service.fetchPopularMovies(query: nil, page: currentPage+1) { [weak self] result in
            
            switch result{
            case .success(let response):
                self?.movies.append(contentsOf: response.results)
                self?.currentPage += 1
//                let indexPathsToReload = self?.calculateIndexPathsToReload(from: response.results)
                self?.handleFetchOfNewPage()
            case .error(let error):
                print("Error in fetching new page: \(error.localizedDescription)")
            }
            
        }
    }
    
    func handleFetchOfNewPage(){
//        guard let newIndexPathsToReload = newIndexPathsToReload else {
//            collectionView?.reloadData()
//            return
//        }
        
//        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
//        collectionView?.reloadItems(at: indexPathsToReload)
        collectionView?.reloadData()
    }
    
}

extension MoviesDataSource: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalResults
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        
        if isLoadingCell(for: indexPath){
            cell.setup(withMovie: nil)
        }else{
            cell.setup(withMovie: self.movies[indexPath.item])
        }
        
        return cell
    }
    
    
}

extension MoviesDataSource: UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.fetchNextPage()
        }
    }
    
}

private extension MoviesDataSource {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= movies.count
    }
    
//    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
//        let indexPathsForVisibleItems = collectionView?.indexPathsForVisibleItems ?? []
//        let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
//        return Array(indexPathsIntersection)
//    }
}
