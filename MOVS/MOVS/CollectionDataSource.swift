//
//  FilmsDataSource.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class CollectionDataSource: NSObject, UICollectionViewDelegate, CollectionWithSearch {
    
    var collection: UICollectionView
    
    var searchController: UISearchController
    
    var filteredFilms: [ResponseFilm] = [ResponseFilm]()
    
    var notFilteredFilms: [ResponseFilm] = [ResponseFilm]()
    
    var totalPages: Int = 1
    
    var shownIndexes : [IndexPath] = []
    
    init(withCollection collection: UICollectionView, andSearchController searchController: UISearchController){
        self.collection = collection
        self.searchController = searchController
        super.init()
        collection.dataSource = self
        collection.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(film: films[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell: EndCollectionViewCell = collectionView.dequeueReusableSupplementaryViewOfKind(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath)
        NetworkManager.shared.page+=1
        if isFiltering{
            let textRequest = self.searchController.searchBar.text!.replacingOccurrences(of: " ", with: "+")
            getSearchMovie(withText: textRequest, andActivityIndicator: cell.outletActivityIndicator)
        }else{
            getNewMovies(withActivityIndicator: cell.outletActivityIndicator)
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        updateSearch(for: searchController)
    }
    
    func errorInSearch() {
        self.collection.alpha = 0
    }
    
    func noFilmsForSearch(withSearch text: String) {
        self.collection.alpha = 0
    }
    
    // TODO: - Move this to CollectionDelegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (!shownIndexes.contains(indexPath)) {
            shownIndexes.append(indexPath)
            
            cell.transform = CGAffineTransform(translationX: 0, y: 40)
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.5)
            cell.transform = CGAffineTransform.identity
            UIView.commitAnimations()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collection.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collection.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform.identity
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collection.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                cell?.transform = CGAffineTransform.identity
            })
        }
    }
}
