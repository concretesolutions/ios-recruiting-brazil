//
//  PopularMoviesMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit

protocol PopularMoviesMiddleDelegate: class {
    func fetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func fetchFailed()
}

class PopularMoviesMiddle {
    
    weak var delegate: PopularMoviesMiddleDelegate?
    var popularMovies: Popular?
    var popularResults: [PopularResults] = []
    var currentPage = 1
    var total = 0
    var isFetchInProgress = false
    
    init(delegate: PopularMoviesMiddleDelegate) {
        self.delegate = delegate
    }
    
    func movieData(at index: Int) -> PopularResults {
        return popularResults[index]
    }
    
    func fetchMovies() {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        
        RequestData.getPopularData(page: currentPage, completion: { (popular: Popular) in
            DispatchQueue.main.async {
                self.currentPage += 1
                self.isFetchInProgress = false
                self.popularMovies = Popular(page: popular.page, total_results: popular.total_results, total_pages: popular.total_pages, results: popular.results)
                self.popularResults = popular.results
                print("FEZ O REQUEST")
                print("popular page \(popular.page)")
                
                if popular.page > 1 {
                    let indexToReload = self.pathsToReload(from: popular.results)
                    self.delegate?.fetchCompleted(with: indexToReload)
                } else {
                    self.delegate?.fetchCompleted(with: .none)
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
    
}
