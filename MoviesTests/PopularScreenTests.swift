//
//  PopularScreenTests.swift
//  MoviesTests
//
//  Created by Matheus Queiroz on 1/14/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import XCTest
@testable import Movies

class popularScreenTests: XCTestCase {

    var testMoviesController = MoviesViewController()
    var testMoviesModel: MoviesViewModel!
    var testMoviesArray = [MovieModel]()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC : MoviesViewController = storyboard.instantiateViewController(withIdentifier: "MoviesVC") as! MoviesViewController
        testMoviesController = moviesVC
        _ = testMoviesController.view
        testMoviesModel = MoviesViewModel(viewController: testMoviesController)
        
        var i = 0
        while(i<5){
            let testMovie = MovieModel(newId: i,
                                       newTitle: "Test Movie \(i)",
                                       newOverview: "This is Just a Test Movie",
                                       newPopularity: 500.00,
                                       newThumbnailPath: "/5Kg76ldv7VxeX9YlcQXiowHgdX6.jpg",
                                       newReleaseDate: "2019-01-01",
                                       newGenresIDArray: [28])
            testMoviesArray.append(testMovie)
            i = i+1
        }
    }

    override func tearDown() {
        testMoviesModel = nil
    }

    func testExample() {
        testMoviesModel.didLoadPopularMoviesWithThumbnail(movies: testMoviesArray)
        var didSaveMovies:Bool = true
        testMoviesArray.forEach{ testMovie in
            didSaveMovies = didSaveMovies && testMoviesModel.moviesArray.contains(testMovie)
        }
        XCTAssertTrue(didSaveMovies)
    }
}
