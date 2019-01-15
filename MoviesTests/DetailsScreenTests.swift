//
//  DetailsScreenTests.swift
//  MoviesTests
//
//  Created by Matheus Queiroz on 1/14/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import XCTest
@testable import Movies

class DetailsScreenTests: XCTestCase {
    
    var testDetailsViewController: DetailsViewController!
    var testMovie: MovieModel!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC : DetailsViewController = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        testDetailsViewController = detailsVC
        
        testMovie = MovieModel(newId: 200,
                                   newTitle: "Test Movie",
                                   newOverview: "This is Just a Test",
                                   newPopularity: 500.00,
                                   newThumbnailPath: "/5Kg76ldv7VxeX9YlcQXiowHgdX6.jpg",
                                   newReleaseDate: "2019-01-01",
                                   newGenresIDArray: [28])
        testDetailsViewController.selectedMovie = testMovie
        _ = testDetailsViewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testDetailsViewController = nil
        testMovie = nil
    }

    func testMovieName() {
        XCTAssertEqual(testDetailsViewController.movieNameLabel.text, testMovie.title)
    }
    
    func testMovieYear() {
        XCTAssertEqual(testDetailsViewController.movieYearLabel.text!, "\(testMovie.releaseYear.year!)")
    }
    
    func testMoviePopularity() {
        XCTAssertEqual(testDetailsViewController.moviePopularityLabel.text!, "Popularity: \(testMovie.popularity)")
    }
    
    func testMovieOverview() {
        XCTAssertEqual(testDetailsViewController.movieDescriptionLabel.text!, testMovie.overview)
    }
}
