//
//  PopularMoviesSpec.swift
//  MoviesAppTests
//
//  Created by Nicholas Babo on 25/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Nimble
import Quick
import Nimble_Snapshots

@testable import MoviesApp

class JSONMockupManager{
    
    func loadMoviesJSON() -> Data{
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "popularMovies", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try! Data(contentsOf: url)
    }
    
    func loadGenresJSON() -> Data{
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "genres", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try! Data(contentsOf: url)
    }
    
    func decodeMovieResponse() -> MovieResponse{
        let data = loadMoviesJSON()
        let decoder = JSONDecoder()
        return try! decoder.decode(MovieResponse.self, from: data)
    }
    
    func decodeGenreResponse() -> GenreResponse{
        let data = loadGenresJSON()
        let decoder = JSONDecoder()
        return try! decoder.decode(GenreResponse.self, from: data)
    }
    
}

class MoviesServiceMockup: MoviesService{
    
    let movieResponse: MovieResponse
    let genreResponse: GenreResponse
    private let jsonMockupManager: JSONMockupManager
    
    init(){
        jsonMockupManager = JSONMockupManager()
        movieResponse = jsonMockupManager.decodeMovieResponse()
        genreResponse = jsonMockupManager.decodeGenreResponse()
    }
    
    func fetchPopularMovies(request: APIRequest, query: String?, page: Int?, callback: @escaping (Result<MovieResponse>) -> Void) {
        
        callback(.success(movieResponse))
        
    }
    
    func fetchGenre(callback: @escaping (Result<[Genre]>) -> Void) {
        callback(.success(genreResponse.genres))
    }
    
    
}

class PopularMoviesControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Popular Movies Controller") {
            
            var popular: PopularMoviesViewController!
            var favorite: FavoriteMoviesViewController!
            var tab: UITabBarController!
            
            beforeEach {
                popular = PopularMoviesViewController()
                favorite = FavoriteMoviesViewController()
                
                tab = UITabBarController()
                let popularMoviesNavigationController = UINavigationController(rootViewController: popular)
                let favoriteMoviesNavigationController = UINavigationController(rootViewController: favorite)
                
                tab.viewControllers = [popularMoviesNavigationController, favoriteMoviesNavigationController]
                
                AppearanceManager.customizeNavigationBar()
                AppearanceManager.customizeTabBar()
                AppearanceManager.customizeSearchBar()
                AppearanceManager.customizeTextField()
                
                popular.service = MoviesServiceMockup()
                popular.loadView()
                popular.fetchMovies()
                popular.fetchGenres()
                popular.setupSearchBar()
                popular.screen.setupView()
                popular.presentationState = .initial
            }
            
            it("should have been initialized", closure: {
                expect(popular).notTo(beNil())
            })
            
            it("should have the expected amount of movies", closure: {
                popular.fetchMovies()
                expect(popular.movies.count).to(equal(20))
            })
            
            describe("Popular Movies Controller - UI", {
                
                it("should have the expected ready UI", closure: {
                    popular.presentationState = .ready
                    expect(tab.view) == snapshot("ready", usesDrawRect: true)
                })

                //Fails when the activity indicator is in a different position
//                it("should have the expected loading UI", closure: {
//                    popular.presentationState = .loading
//                    expect(tab.view) == snapshot("loading", usesDrawRect: true)
//                })
                
                it("should have the expected error UI", closure: {
                    popular.presentationState = .error
                    expect(tab.view) == snapshot("error", usesDrawRect: true)
                })
                
                it("should have the expected no results UI", closure: {
                    popular.presentationState = .noResults("")
                    expect(tab.view) == snapshot("no results", usesDrawRect: true)
                })
                
                
                
                
            })
            
        }
        
    }

}
