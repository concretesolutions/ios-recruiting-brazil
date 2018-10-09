//
//  MoviesCollectionViewManager.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesCollectionViewManager: NSObject {
    
    private var presenterProtocol: MoviesListPresenterProtocol?
    private var favIdList: [Int]?
    private var collectionView: UICollectionView?
    
    private var searchActive : Bool = false
    private let collectionViewPadding: CGFloat = 10
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    init(with presenter: MoviesListPresenterProtocol, _ collectionView: UICollectionView) {
        presenterProtocol = presenter
        self.collectionView = collectionView
    }
}

//MARK: - SearchBar methods -
extension MoviesCollectionViewManager: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchController.dismiss(animated: true) {
            self.presenterProtocol?.changeSearchCollectionState(shouldShowEmptySearch: false)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        presenterProtocol?.filterList(with: searchController.searchBar.text ?? "")
        presenterProtocol?.changeSearchCollectionState(shouldShowEmptySearch: presenterProtocol?.filteredList.isEmpty ?? true)
        collectionView?.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        presenterProtocol?.cancelTasks()
        presenterProtocol?.changeSearchCollectionState(shouldShowEmptySearch: presenterProtocol?.filteredList.isEmpty ?? true)
        collectionView?.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        presenterProtocol?.changeSearchCollectionState(shouldShowEmptySearch: presenterProtocol?.filteredList.isEmpty ?? true)
        collectionView?.reloadData()
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
        if searchActive {
            return 1
        } else {
            return presenterProtocol?.moviesLists?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return presenterProtocol?.filteredList.count ?? 0
        } else {
            return presenterProtocol?.moviesLists?[section].count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searchActive {
            return getCellForSearchCollection(with: indexPath, for: collectionView)
        } else {
            return getCellForNormalCollection(with: indexPath, for: collectionView)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        let seventyPercent = scrollView.contentSize.height * 0.7
        if scrollPosition >= seventyPercent {
            presenterProtocol?.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenterProtocol?.openMovieDetail(to: indexPath, comeFromSearch: searchActive)
    }
    
    private func getCellForNormalCollection(with indexPath: IndexPath, for collectionView: UICollectionView) -> UICollectionViewCell {
        guard let movies = presenterProtocol?.moviesLists?[indexPath.section] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(with: MovieCell.self, for: indexPath)
        cell.delegate = self
        cell.model = movies[indexPath.item]
        return cell
    }
    
    private func getCellForSearchCollection(with indexPath: IndexPath, for collectionView: UICollectionView) -> UICollectionViewCell {
        guard let movie = presenterProtocol?.filteredList[indexPath.item] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(with: MovieCell.self, for: indexPath)
        cell.delegate = self
        cell.model = movie
        return cell
    }
}

extension MoviesCollectionViewManager: MovieCellDelegate {
    func downloadImage(to model: MovieModel, completion: @escaping (ResponseResultType<Data>, String) -> Void) {
        presenterProtocol?.getMoviePoster(to: model, completion: completion)
    }
}
