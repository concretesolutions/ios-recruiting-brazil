//
//  MovieFilterTests.swift
//  ConcreteChallengeTests
//
//  Created by Erick Pinheiro on 30/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import XCTest
import ReSwift
import ReSwiftThunk


@testable import ConcreteChallenge

class MovieFilterTests: XCTestCase {
    
    let movieFactory = MovieFactory()
    
    func testShouldSetupWithDefaults() {
        let filters = MovieFilters()
        XCTAssertEqual(filters.language, "pt-BR", "Default language is incorrect")
        XCTAssertEqual(filters.page, 1, "Default page should be 1")
        XCTAssertNil(filters.query, "Query should NOT be set")
        XCTAssertNil(filters.parameters, "Query should be nil")
        XCTAssertTrue(filters.isEmpty, "'isEmpty' should be true")
    }
    
    func testShouldSetAllParametersCorrectly() {
        let filters = movieFactory.getFullyFilledFilter()
        
        XCTAssertEqual(filters.query, movieFactory.movieSearchQuery, "Query is incorrect")
        XCTAssertEqual(filters.language, "en-US", "Language is incorrect")
        XCTAssertEqual(filters.page, 2, "Page is incorrect")
        XCTAssertTrue(filters.includeAdult!, "IncludeAdult is incorrect")
        XCTAssertEqual(filters.region, "US", "Region is incorrect")
        XCTAssertEqual(filters.year, 2020, "Year is incorrect")
        XCTAssertEqual(filters.primaryReleaseYear, 2021, "PrimaryReleaseYear is incorrect")
        XCTAssertNotNil(filters.parameters, "Query should NOT be nil")
        XCTAssertFalse(filters.isEmpty, "'isEmpty' should be false")
    }

    func testShouldGenerateParameterCorrectly() {
        let filters = movieFactory.getFullyFilledFilter()
        
        filters.search(for: movieFactory.movieSearchQuery)
        
        if let parameters = filters.parameters {
            XCTAssertEqual(parameters["query"] as! String, movieFactory.movieSearchQuery, "Query is incorrect")
            XCTAssertEqual(parameters["language"] as! String, "en-US", "Language is incorrect")
            XCTAssertEqual(parameters["page"] as! Int, 2, "Page is incorrect")
            XCTAssertNil(parameters["includeAdult"], "IncludeAdult is incorrect")
            XCTAssertEqual(parameters["region"] as! String, "US", "Region is incorrect")
            XCTAssertEqual(parameters["year"] as! Int, 2020, "Year is incorrect")
            XCTAssertEqual(parameters["primaryReleaseYear"] as! Int, 2021, "PrimaryReleaseYear is incorrect")
            XCTAssertFalse(filters.isEmpty, "'isEmpty' should be false")
        } else {
            XCTFail("Query should NOT be nil")
        }
    }
    
    
    func testShouldCloneCorrectly() {
        let filters = movieFactory.getFullyFilledFilter()
        
        do {
            let clone = try filters.clone()
            
            XCTAssertEqual(filters.query, clone.query, "Query is incorrect")
            XCTAssertEqual(filters.language, clone.language, "Language is incorrect")
            XCTAssertEqual(filters.page, clone.page, "Page is incorrect")
            XCTAssertEqual(filters.includeAdult!, clone.includeAdult!,"IncludeAdult is incorrect")
            XCTAssertEqual(filters.region, clone.region, "Region is incorrect")
            XCTAssertEqual(filters.year, clone.year, "Year is incorrect")
            XCTAssertEqual(filters.primaryReleaseYear, clone.primaryReleaseYear, "PrimaryReleaseYear is incorrect")
            XCTAssertNotNil(clone.parameters, "Query should NOT be nil")
            XCTAssertNotNil(clone.parameters, "Query should NOT be nil")
            XCTAssertFalse(filters.isEmpty, "'isEmpty' should be false")
        } catch {
            XCTFail("Should not fail to clone")
        }

    }
}
