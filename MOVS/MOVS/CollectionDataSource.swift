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
    
    init(withCollection collection: UICollectionView, andSearchController searchController: UISearchController){
        self.collection = collection
        self.searchController = searchController
        super.init()
        searchController.searchResultsUpdater = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(withFilm: films[indexPath.row])
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
        guard let superView = self.collection.superview else {
            print("Collection didn't have superView in: \(CollectionDataSource.self)")
            return
        }
        let reportView = superView.viewWithTag(1) as! ReportView
        reportView.alpha = 0
        updateSearch(for: searchController)
    }
    
    func errorInSearch() {
        DispatchQueue.main.async {
            guard let superView = self.collection.superview else {
                print("Collection didn't have superView in: \(CollectionDataSource.self)")
                return
            }
            let reportView = superView.viewWithTag(1) as! ReportView
            reportView.alpha = 1
            reportView.imageView.image = UIImage(named: "Error")
            reportView.label.text = "Um erro ocorreu. Por favor, tente novamente"
        }
    }
    
    func noFilmsForSearch(withSearch text: String) {
        DispatchQueue.main.async {
            guard let superView = self.collection.superview else {
                print("Collection didn't have superView in: \(CollectionDataSource.self)")
                return
            }
            let reportView = superView.viewWithTag(1) as! ReportView
            reportView.alpha = 1
            reportView.imageView.image = UIImage(named: "NoResult")
            reportView.label.text = "Não houve resultado para \"\(text)\""
        }
    }
}
