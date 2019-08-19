//
//  MovieServiceMock.swift
//  AppMovieTests
//
//  Created by ely.assumpcao.ndiaye on 16/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//
@testable import AppMovie

class MovieServiceMock: MovieService {
    
    let movies: [Result]
    private let jsonHelper: JsonHelper
    
    init() {
        self.jsonHelper = JsonHelper()
        self.movies = jsonHelper.decodeJson()
        //print(self.moviesS)
    }
    
    func getMovies(page: Int, completionHandler: @escaping ([Result]) -> Void) {
        completionHandler(self.movies)
    }
}
