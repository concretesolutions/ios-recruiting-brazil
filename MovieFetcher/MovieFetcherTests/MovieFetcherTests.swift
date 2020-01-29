//
//  MovieFetcherTests.swift
//  MovieFetcherTests
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import XCTest
@testable import MovieFetcher

class MovieFetcherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApi() {
        
        var testMovie:MovieSearch!
        
        let anonymousFunc = {(fetchedData:MovieSearch) in
            testMovie = fetchedData
            XCTAssertNotNil(testMovie, "Returned a movie search")
            XCTAssert(type(of: testMovie) == MovieSearch.self, "Movie conforms to movie search class")
        }
        api.movieSearch(urlStr: dao.searchURL, view: UIViewController(), onCompletion: anonymousFunc)
    }
    
    func testRandomAPI(){
        
        var image:UIImage!
        let photoURL = "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"
        let anonymousFunc = {(fetchedData:UIImage) in
            image = fetchedData
            XCTAssertNotNil(image, "Returned a Image")
            XCTAssert(type(of: image) == UIImage.self, "Result conforms to UIImage class")
        }
        api.retrieveImage(urlStr: photoURL, onCompletion: anonymousFunc)
    }
    
    
    

  
    

}
