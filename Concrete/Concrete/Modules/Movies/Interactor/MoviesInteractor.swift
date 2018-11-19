//
//  MoviesInteractor.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

protocol MoviesInteractorDelegate:class {
    func isLoading(_ loading:Bool)
    func didLoad()
    func didFail(error: Error)
}

class MoviesInteractor: NSObject {

    //MARK: - Properties
    // MARK: Private
    private var fetchedMovies = [Movie]()
    private var searchedMovies = [Movie]()
    
    // MARK: Public
    private(set) var pageLastModified:Int = 0
    private(set) var page:Int = 0
    var movies:[Movie] {
        if self.isSearching {
            return self.searchedMovies
        }else{
            return self.fetchedMovies
        }
    }
    
    private(set) var isSearching = false
    weak var delegate:MoviesInteractorDelegate?
    
    //MARK: - Init
    
    //MARK: - Functions
    func fetchMovies(page: Int? = nil) {
        
        self.pageLastModified = self.page
        if let pageVerified = page {
            if pageVerified >= self.page {
                self.page += 1
            } else {
                self.page = self.page <= 0 ? 0: self.page - 1
            }
        }
        
        let request = GetPopularMovies(page: page)
        
        APIManager.shared.fetch(request) { (result) in
            switch result {
            case .success(let resultMovies):
                self.fetchedMovies.append(contentsOf: resultMovies.results)
                self.delegate?.didLoad()
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
}
