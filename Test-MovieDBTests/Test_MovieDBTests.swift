//
//  Test_MovieDBTests.swift
//  Test-MovieDBTests
//
//  Created by Gabriel Soria Souza on 16/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import XCTest
@testable import Test_MovieDB

class Test_MovieDBTests: XCTestCase {
    
    let popular = PopularMoviesViewController()
    var popularMiddle: PopularMoviesMiddle!
    
    override func setUp() {
        popularMiddle = PopularMoviesMiddle(delegate: popular as PopularMoviesMiddleDelegate)
    }
    
    func test_middleIsNotNil() {
        XCTAssertNotNil(popularMiddle)
    }
    
    func test_popularResultsIsEmpty() {
        XCTAssertTrue(popularMiddle.popularResults.isEmpty, "It is empty")
    }
    
    func test_popularResultsAfterFetchIsNotEmpty() {
        //given
        var thePopular: Popular!
        var theResults: [PopularResults] = []
        let expectation = XCTestExpectation(description: "Popular results shall not be zero")
        
        //when
        RequestData.getPopularData(page: 1, completion: { (popular: Popular) in
            DispatchQueue.main.async {
                thePopular = Popular(page: popular.page, total_results: popular.total_results, total_pages: popular.total_pages, results: popular.results)
                theResults.append(contentsOf: thePopular!.results)
                
                //then
                XCTAssertFalse(theResults.isEmpty, "It is not empty now")
                expectation.fulfill()
            }
        }) { (error) in
            DispatchQueue.main.async {
                print(error)
            }
        }
        wait(for: [expectation], timeout: 25)
    }
    
    func test_searchMovies() {
        //given
        var search: SearchResultsWorker!
        var searchResults: [ResultsOfSearchWorker] = []
        let expectation = XCTestExpectation(description: "Search results shall not be nil")
        
        //when
        RequestData.getSearchData(searchString: "spider-man", page: 1, completion: { (searchData: SearchResultsWorker) in
            DispatchQueue.main.async {
                search = SearchResultsWorker(page: searchData.page, results: searchData.results, total_pages: searchData.total_pages, total_results: searchData.total_results)
                searchResults.append(contentsOf: search.results)
                
                //then
                XCTAssertFalse(searchResults.isEmpty, "It is not empty")
                expectation.fulfill()

            }
        }) { (error) in
            DispatchQueue.main.async {
                print(error)
            }
        }
        wait(for: [expectation], timeout: 25)
    }
}
