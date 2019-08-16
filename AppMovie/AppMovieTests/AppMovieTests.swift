//
//  AppMovieTests.swift
//  AppMovieTests
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Quick
import Nimble
import XCTest
@testable import AppMovie


class MovieServiceMock: MovieService {
    
    let movieX: [Result]
    private let jsonHelper: JsonHelper
    
    init() {
        self.jsonHelper = JsonHelper()
        self.movieX = jsonHelper.decodeJson()
        //print(self.moviesS)
    }
    
    func getMovies(page: Int, completionHandler: @escaping ([Result]) -> Void) {
         completionHandler(self.movieX)
    }
}


class FirstSpec: QuickSpec {
    override func spec() {
        describe("Describle First Spec Test") {
            it("Should be true") {
                expect(true).to(beTruthy())
            }
        }
    }
}

class MovieSearchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieSearchViewController") {
            
            var sut: MovieSearchViewController!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieSearchViewController") as? MovieSearchViewController else {
                    fatalError("should be a controller of type MovieDetailViewController")
                }
                
                // let nav = storyboard.instantiateInitialViewController() as! UINavigationController
                
                sut = controller
                print(sut)
                //  sut = nav.topViewController as! MovieSearchViewController
               // sut.service = MovieServiceMock()
                sut.setupView(service: MovieServiceMock())
                sut.api()
                print(sut.movie.count)
                _ = sut.view
                print(sut.movie.count)
                let test = MovieServiceMock()
                //print(test.moviesS)
                
                //_ = sut.view
            }
            
            it("should have a valid instance") {
                expect(sut).toNot(beNil())
            }
            
            //            it("should have the expected number of characters") {
            //                expect(sut.characters.count).to(equal(6))
            //            }
        }
    }
}

class AppMovieTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
