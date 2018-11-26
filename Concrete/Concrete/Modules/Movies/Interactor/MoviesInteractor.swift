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
    
    enum Status {
        case normal
        case searching(query:String)
    }
    
    //MARK: - Properties
    // MARK: Private
    //Popular
    private var fetchedMovies = [Movie]()
    private var popularMoviesPage:Int = 1
    //Search
    private var searchedMovies = [Movie]()
    private var searchMoviesPage:Int = 1
    
    // MARK: Public
    private(set) var pageLastModified:Int = 1
    private(set) var status:Status = .normal
    
    var page:Int {
        switch self.status {
        case .normal:
            return self.popularMoviesPage
        case .searching:
            return self.searchMoviesPage
        }
    }
    
    var movies:[Movie] {
        switch self.status {
        case .normal:
            return self.fetchedMovies
        case .searching:
            return self.searchedMovies
        }
    }
    
    weak var delegate:MoviesInteractorDelegate?
    
    //MARK: - Init
    
    //MARK: - Functions
    //MARK: Private
    private func fetchPopularMovies(page: Int? = nil) {
        
        //TODO: Modified function to work for searching and fetchMovies
        self.pageLastModified = self.page
        if let pageVerified = page {
            if pageVerified >= self.page {
                self.popularMoviesPage = pageVerified
            } else {
                self.popularMoviesPage = self.page <= 1 ? 1: self.popularMoviesPage - 1
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
    
    
    private func fetchSearchMovies(query: String, page: Int? = nil) {
        
        self.pageLastModified = self.page
        if let pageVerified = page {
            if pageVerified >= self.page {
                self.searchMoviesPage = pageVerified
            } else {
                self.searchMoviesPage = self.page <= 1 ? 1: self.searchMoviesPage - 1
            }
        }
        
        let request = GetSearchMovies(query: query, page: page)
        
        APIManager.shared.fetch(request) { (result) in
            switch result {
            case .success(let resultMovies):
                self.searchedMovies.append(contentsOf: resultMovies.results)
                self.delegate?.didLoad()
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
    
    private func cleanSearchData() {
        self.searchMoviesPage = 1
        self.pageLastModified = 1
        self.searchedMovies = [Movie]()
    }
    
    private func cleanPopularData() {
        self.pageLastModified = 1
        self.popularMoviesPage = 1
        self.fetchedMovies = [Movie]()
    }
    
    private func cleanAll() {
        self.cleanSearchData()
        self.cleanPopularData()
    }
    
    //MARK: Public
    func reload() {
        self.cleanAll()
        
        self.fetchMovies()
    }
    
    func cancelSearch() {
        self.cleanSearchData()
        self.status = .normal
    }
    
    func change(status: Status) {
        self.cleanSearchData()
        self.status = status
    }
    
    func fetchMovies(page: Int? = nil) {
        //Activate search
        switch self.status {
        case .normal:
            self.fetchPopularMovies(page: page)
        case .searching(let query):
            self.fetchSearchMovies(query: query, page: page)
        }
    }
    
    func set(movie:Movie, isFavorited:Bool) {
        movie.isFavorited = isFavorited
    }
}
