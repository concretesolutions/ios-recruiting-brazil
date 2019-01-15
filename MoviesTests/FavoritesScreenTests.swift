//
//  FavoritesScreenTests.swift
//  MoviesTests
//
//  Created by Matheus Queiroz on 1/14/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import XCTest
@testable import Movies

class FavoritesScreenTests: XCTestCase {

    var testFavoritesController = FavoriteMoviesViewController()
    var testFavoritesModel: FavoriteMoviesViewModel!
    var testFavoriteMoviesArray = [MovieModel]()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let favoritesVC : FavoriteMoviesViewController = storyboard.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoriteMoviesViewController
        testFavoritesController = favoritesVC
        _ = testFavoritesController.view
        testFavoritesModel = FavoriteMoviesViewModel(viewController: testFavoritesController)
        
        var i = 0
        while(i<5){
            let testMovie = MovieModel(newId: i,
                                       newTitle: "Test Movie \(i)",
                                       newOverview: "This is Just a Test Movie",
                                       newPopularity: 500.00,
                                       newThumbnailPath: "/5Kg76ldv7VxeX9YlcQXiowHgdX6.jpg",
                                       newReleaseDate: "2019-01-01",
                                       newGenresIDArray: [28])
            testFavoriteMoviesArray.append(testMovie)
            i = i+1
        }
        testFavoritesModel.favoriteMoviesArray = testFavoriteMoviesArray
    }

    override func tearDown() {
        testFavoritesModel = nil
    }

    func testRemoveFromFavorites() {
        let randomIndex = Int.random(in: 0..<testFavoriteMoviesArray.count)
        let movieToRemove = testFavoriteMoviesArray[randomIndex]
        testFavoritesModel.remove(fromFavorites: movieToRemove)
        let isMovieInArray = testFavoritesModel.favoriteMoviesArray.contains(movieToRemove)
        XCTAssertFalse(isMovieInArray)
    }

}
