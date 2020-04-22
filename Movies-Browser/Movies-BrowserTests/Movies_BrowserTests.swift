//
//  Movies_BrowserTests.swift
//  Movies-BrowserTests
//
//  Created by Gustavo Severo on 17/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import XCTest
@testable import Movies_Browser

class Movies_BrowserTests: XCTestCase {

    let database = Database()
    
    // MARK: - Movie Detail Tests -
    func testFavoriteActionInMovieDetail() {
        var isFavorite: Bool = false
        let movie = Movie(id: 0, title: "Batman", releaseDate: "2020-04-20".dateFromText() ?? Date(), overview: "Lorem ipsum", genreIds: [], posterPath: "")
        let viewModel = MovieDetailViewModel(movie: movie) { state in
            isFavorite = state.isFavorite
        }
        viewModel.favoriteButtonWasTapped()
        XCTAssert(isFavorite)
    }

    func testUnfavoriteActionInMovieDetail() {
        var isFavorite: Bool = false
        let movie = Movie(id: 0, title: "Batman", releaseDate: "2020-04-20".dateFromText() ?? Date(), overview: "Lorem ipsum", genreIds: [], posterPath: "")
        let viewModel = MovieDetailViewModel(movie: movie) { state in
            isFavorite = state.isFavorite
        }
        viewModel.favoriteButtonWasTapped()
        viewModel.favoriteButtonWasTapped()
        XCTAssert(!isFavorite)
    }
    
    func testDataPresentationOnMovieDetail() {
        let movie = Movie(id: 0, title: "Batman", releaseDate: "2020-04-20".dateFromText() ?? Date(), overview: "Lorem ipsum", genreIds: [], posterPath: "")
        let viewModel = MovieDetailViewModel(movie: movie, callback: nil)
        viewModel.callback = { [weak self] state in
            XCTAssert(state.isFavorite == self?.database.isFavorited(id: movie.id))
            XCTAssert(state.titleText == movie.title)
            XCTAssert(state.descriptionText == movie.overview)
            XCTAssert(state.releaseDateText == movie.releaseDate.year)
            XCTAssert(state.genreListText == self?.database.getGenresListString(ids: movie.genreIds))
        }
    }
}

// MARK: - Favorites List Persistence Tests -
extension Movies_BrowserTests {
    func testClearFavoritesList(){
        database.clearFavoritesList()
        let favoritesList = database.getFavoritesList()
        XCTAssert(favoritesList.isEmpty)
    }
    
    func testGetFavoritesListAfterAddingOneMovie(){
        let movie = Movie(id: 156, title: "Batman", releaseDate: "2020-04-20".dateFromText() ?? Date(), overview: "Lorem ipsum", genreIds: [5, 25], posterPath: "")
        
        database.clearFavoritesList()
        database.addNewFavorite(movie: movie)
        
        let favoritesList = database.getFavoritesList()
        XCTAssert(favoritesList.count == 1 && favoritesList[0] == movie)
    }
    
    func testGetFavoritesListAfterRemovingOneMovie(){
        let firstMovie = Movie(id: 156, title: "Batman", releaseDate: "2020-04-20".dateFromText() ?? Date(), overview: "Lorem ipsum", genreIds: [5, 25], posterPath: "")
        let secondMovie = Movie(id: 240, title: "Batman II", releaseDate: "2020-04-20".dateFromText() ?? Date(), overview: "Lorem ipsum II", genreIds: [40], posterPath: "")
        
        database.clearFavoritesList()
        database.addNewFavorite(movie: firstMovie)
        database.addNewFavorite(movie: secondMovie)
        
        var favoritesList = database.getFavoritesList()
        XCTAssert(favoritesList.count == 2 && favoritesList[0] == firstMovie && favoritesList[1] == secondMovie)
        database.deleteFavorite(id: secondMovie.id)
        favoritesList = database.getFavoritesList()
        XCTAssert(favoritesList.count == 1 && favoritesList[0] == firstMovie)
    }
}

// MARK: - Genres List Persistence Tests -
extension Movies_BrowserTests {
    func testClearGenresList(){
        database.clearGenresList()
        let genresList = database.getGenresList()
        XCTAssert(genresList.isEmpty)
    }
    func testGetGenresListAfterAddingAListOfGenres(){
        let genresArray = [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy"), Genre(id: 2, name: "Romance")]
        
        database.clearGenresList()
        database.setGenresList(genresList: genresArray)
        
        let genresList = database.getGenresList()
        XCTAssert(genresList.count == 3 && genresList == genresArray)
    }
    func testGetGenresListString(){
        let genresArray = [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy"), Genre(id: 2, name: "Romance")]
        let movie = Movie(id: 156, title: "Batman", releaseDate: "2020-04-20".dateFromText() ?? Date(), overview: "Lorem ipsum", genreIds: [0, 1], posterPath: "")
        
        database.clearGenresList()
        database.setGenresList(genresList: genresArray)
        let genresList = database.getGenresList()
        let genresListString = database.getGenresListString(ids: movie.genreIds)
        XCTAssert(genresListString ==
            "\(genresList.filter({ $0.id == movie.genreIds[0] }).first!.name), \(genresList.filter({ $0.id == movie.genreIds[1] }).first!.name)")
    }
}

// MARK: - Genres List Request Tests -
extension Movies_BrowserTests {
    func testGenresListRequest(){
        var genresList: GenresList?
        let expectation = self.expectation(description: "GenresListRequest")
        
        Service.request(router: Router.getMoviesGenres) { (genres: GenresList?, success: Bool) in
            genresList = genres
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        database.setGenresList(genresList: genresList?.genres ?? [])
        XCTAssert(genresList != nil)
    }
    
    func testGenresListPersistenceAfterRequest(){
        testGenresListRequest()
        let database = Database()
        let genresList = database.getGenresList()
        XCTAssert(genresList.count > 0)
    }
}
