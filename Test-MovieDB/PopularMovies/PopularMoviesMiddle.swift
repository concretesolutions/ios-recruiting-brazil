//
//  PopularMoviesMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit

//MARK: - POPULAR MOVIES MIDDLE DELEGATE

protocol PopularMoviesMiddleDelegate: class {
    func fetchCompleted()
    func fetchFailed()
    func fetchWithNewPageResults(paths: [IndexPath])
    func searchResultNil()
}

class PopularMoviesMiddle {
    
    //MARK: - PROPERTIES
    
    weak var delegate: PopularMoviesMiddleDelegate?
    var popularMovies: Popular?
    var searchResults: SearchResultsWorker?
    var popularResults: [PopularResults] = []
    var searchResultArray: [ResultsOfSearchWorker] = []
    var currentPage = 1
    var total = 0
    var isFetchInProgress = false
    
    //MARK: - INITIALIZERS
    
    init(delegate: PopularMoviesMiddleDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - METHODS
    
    func movieData(at index: Int) -> PopularResults {
        return popularResults[index]
    }
    
    func searchData(at index: Int) -> ResultsOfSearchWorker {
        return searchResultArray[index]
    }
    
    func fetchMovies() {
        if self.currentPage == 0 {
            self.currentPage += 1
        }
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        RequestData.getPopularData(page: currentPage, completion: { (popular: Popular) in
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.popularMovies = Popular(page: popular.page, total_results: popular.total_results, total_pages: popular.total_pages, results: popular.results)
                if self.currentPage < popular.total_pages {
                    self.currentPage += 1
                    self.popularResults.append(contentsOf: popular.results)
                }
                if self.currentPage <= 2 {
                    self.delegate?.fetchCompleted()
                } else {
                    let indexPathToReload = self.pathsToReload(from: popular.results)
                    self.delegate?.fetchWithNewPageResults(paths: indexPathToReload)
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                print(error)
                self.delegate?.fetchFailed()
            }
        }
    }
        
        func searchMovies(searchString: String) {
            if self.currentPage == 0 {
                self.currentPage += 1
            }
            self.popularResults.removeAll()
            
            guard !isFetchInProgress else { return }
            let stringTrimmed = searchString.replacingOccurrences(of: " ", with: "")
            
            isFetchInProgress = true
            
            RequestData.getSearchData(searchString: stringTrimmed, page: currentPage, completion: { (searchData: SearchResultsWorker) in
                DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.searchResults = SearchResultsWorker(page: searchData.page, results: searchData.results, total_pages: searchData.total_pages, total_results: searchData.total_results)
                    if searchData.total_results == 0 {
                        self.delegate?.searchResultNil()
                    }
                    if self.currentPage < searchData.total_pages {
                        self.currentPage += 1
                        self.searchResultArray.append(contentsOf: searchData.results)
                    }
                    if self.currentPage <= 2 {
                        self.delegate?.fetchCompleted()
                    } else {
                        let indexPathToReload = self.searchPathsToReload(from: searchData.results)
                        self.delegate?.fetchWithNewPageResults(paths: indexPathToReload)
                    }
                }
            }) { (error) in
                DispatchQueue.main.async {
                    print(error)
                    self.delegate?.fetchFailed()
                }
            }
        }
    
    func pathsToReload(from results: [PopularResults]) -> [IndexPath] {
        let startIndex = popularResults.count - results.count
        let endIndex = startIndex + results.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func searchPathsToReload(from results: [ResultsOfSearchWorker]) -> [IndexPath] {
        let startIndex = searchResultArray.count - results.count
        let endIndex = startIndex + results.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
