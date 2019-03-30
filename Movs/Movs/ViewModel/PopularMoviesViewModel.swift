//
//  PopularMovieViewModel.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import RxSwift
import RxCocoa

class PopularMoviesViewModel {
    //MARK: Variables
    private var movieList = BehaviorRelay<[Movie]>(value: [])
    private var page = 0
    
    //MARK: - RXObservable
    var moviesObservable: Observable<[Movie]> {
        return self.movieList.asObservable()
    }
    
    //MARK: - Subscript
    subscript(index: Int) -> MovieViewModel {
        if index > count - 5 {
            fetchMoreMovies()
        }
        return MovieViewModel(movieList.value[index])
    }
    
    var count: Int {
        return movieList.value.count
    }
    
    //MARK: - Init
    init() {
        fetchMoreMovies()
    }
    
    //MARK: - Fatch more movies
    private func fetchMoreMovies() {
        page = page + 1
        APIClient.getPopularMovies(page: page) { [unowned self] result in
            switch result {
            case .success(let movies):
                self.movieList.accept(self.movieList.value + movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
