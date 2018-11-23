//
//  CollectionWithSearch.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

protocol CollectionWithSearch: UICollectionViewDataSource, SearchProtocol{
    var collection: UICollectionView { get set }
    
    var filteredFilms: [ResponseFilm] { get set }
    
    var notFilteredFilms: [ResponseFilm] { get set }
    
    var totalPages: Int { get set }
    
    func errorInSearch()
    
    func noFilmsForSearch(withSearch text: String)
}

extension CollectionWithSearch{
    var films: [ResponseFilm] {
        get {
            if isFiltering{
                return filteredFilms
            }else{
                return notFilteredFilms
            }
        }
        
        set {
            if isFiltering{
                self.filteredFilms = newValue
            }else{
                self.notFilteredFilms = newValue
            }
        }
    }
    
    func getNewMovies(withActivityIndicator activity: UIActivityIndicatorView? = nil){
        
        if totalPages >= NetworkManager.shared.page {
            activity?.alpha = 1
            activity?.startAnimating()
            NetworkManager.shared.fetchMovies(withRequest: RequestType.feed) { (result) in
                self.handleResponse(response: result, andActivity: activity)
            }
        }else{
            activity?.alpha = 0
        }
    }
    
    func getSearchMovie(withText text: String, andActivityIndicator activity: UIActivityIndicatorView? = nil){
        if totalPages >= NetworkManager.shared.page {
            activity?.alpha = 1
            activity?.startAnimating()
            NetworkManager.shared.fetchMovies(withRequest: RequestType.search, andSearchText: text) { (result) in
                self.handleResponse(response: result, withText: text, andActivity: activity)
            }
        }else{
            activity?.alpha = 0
        }
    }
    
    func handleResponse(response: (Result<Response, APIError>), withText text: String? = nil, andActivity activity: UIActivityIndicatorView? = nil){
        switch response{
        case .success(let filmsResponse):
            guard let films = filmsResponse.results else {
                print("Error to cast films from response in: \(CollectionDataSource.self)")
                return
            }
            if let totalPages = filmsResponse.total_pages{
                self.totalPages = totalPages
            }
            DispatchQueue.main.async {
                if films.count > 0 {
                    self.collection.alpha = 1
                    self.collection.performBatchUpdates({
                        var indexPaths: [IndexPath] = [IndexPath]()
                        for i in self.films.count...self.films.count+films.count-1{
                            indexPaths.append(IndexPath(row: i, section: 0))
                        }
                        self.films.append(contentsOf: films)
                        self.collection.insertItems(at: indexPaths)
                    }, completion: nil)
                    activity?.stopAnimating()
                }else{
                    if let text = text {
                        self.noFilmsForSearch(withSearch: text)
                    }
                }
            }
        case .failure(let error):
            print("Error \(error.localizedDescription) in: \(CollectionDataSource.self)")
            errorInSearch()
        }
    }
    
    func updateSearch(for searchController: UISearchController){
        NetworkManager.shared.page = 1
        self.totalPages = 1
        self.collection.reloadData()
        self.films = [ResponseFilm]()
        if isFiltering{
            let textRequest = searchController.searchBar.text!.replacingOccurrences(of: " ", with: "+")
            getSearchMovie(withText: textRequest)
        }else{
            getNewMovies()
        }
    }
}
