//
//  APITest.swift
//  XPInvestimentoTests
//
//  Created by Kaique Magno Dos Santos on 22/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import XCTest
@testable import Concrete

class APITest: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetCharactersRequest() {
        let waiter = XCTWaiter(delegate: self)
        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
        
        let request = GetPopularMovies()
        
        APIManager.shared.fetch(request) { (response) in
            switch response {
            case .success(let dataContainer):
                XCTAssert(dataContainer.totalResults > 0)
                answerAPIExpectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
                answerAPIExpectation.fulfill()
                print(error.localizedDescription)
            }
        }
        
        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
    }
//    
//    func testGetCharactersRequestNameStartWith() {
//        let waiter = XCTWaiter(delegate: self)
//        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
//        
//        let name = "Thor"
//        let request = GetCharacters(nameStartsWith: name)
//        
//        APIManager.shared.send(request) { (response) in
//            switch response {
//            case .success(let dataContainer):
//                XCTAssertNotNil(dataContainer.results)
//                XCTAssertNotNil(dataContainer.results.count > 0)
//                
//                for character in dataContainer.results {
//                    //Test if the character has contain the name which was used as parameter of the request
//                    XCTAssert(character.name!.contains(name))
//                }
//                
//                answerAPIExpectation.fulfill()
//                
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//                answerAPIExpectation.fulfill()
//                print(error.localizedDescription)
//            }
//        }
//        
//        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
//    }
//    
//    func testGetCharactersRequestName() {
//        let waiter = XCTWaiter(delegate: self)
//        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
//        
//        let name = "Thor"
//        let request = GetCharacters(name: name)
//        
//        APIManager.shared.send(request) { (response) in
//            switch response {
//            case .success(let dataContainer):
//                XCTAssertNotNil(dataContainer.results)
//                XCTAssertNotNil(dataContainer.results.count > 0)
//                
//                for character in dataContainer.results {
//                    //Test if the character has the same name which was used as parameter of the request
//                    XCTAssert(character.name! == name)
//                }
//                
//                answerAPIExpectation.fulfill()
//                
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//                answerAPIExpectation.fulfill()
//                print(error.localizedDescription)
//            }
//        }
//        
//        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
//    }
//    
//    func testGetCharactersRequestPagination() {
//        let waiter = XCTWaiter(delegate: self)
//        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
//        
//        var firstRequestCharacters = Array<XPInvestimento.Character>()
//        let request = GetCharacters()
//        
//        APIManager.shared.send(request) { (response) in
//            switch response {
//            case .success(let dataContainer):
//                XCTAssertNotNil(dataContainer.results)
//                XCTAssertNotNil(dataContainer.results.count > 0)
//                firstRequestCharacters = dataContainer.results
//                answerAPIExpectation.fulfill()
//                
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//                answerAPIExpectation.fulfill()
//                print(error.localizedDescription)
//            }
//        }
//        
//        var secondRequestCharacters = Array<XPInvestimento.Character>()
//        let paginationRequest = GetCharacters(offset:20)
//        
//        APIManager.shared.send(paginationRequest) { (response) in
//            switch response {
//            case .success(let dataContainer):
//                XCTAssertNotNil(dataContainer.results)
//                XCTAssertNotNil(dataContainer.results.count > 0)
//                secondRequestCharacters = dataContainer.results
//                for secondCharacter in secondRequestCharacters {
//                    for firstCharacter in firstRequestCharacters {
//                        //Test if all character from the first request are different from the characters in the second request
//                        XCTAssert(firstCharacter != secondCharacter)
//                    }
//                }
//                answerAPIExpectation.fulfill()
//                
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//                answerAPIExpectation.fulfill()
//                print(error.localizedDescription)
//            }
//        }
//        
//        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
//    }
    
    // MARK: - XCTWaiterDelegate
    override func waiter(_ waiter: XCTWaiter, didFulfillInvertedExpectation expectation: XCTestExpectation) {
        
    }
    override func waiter(_ waiter: XCTWaiter, didTimeoutWithUnfulfilledExpectations unfulfilledExpectations: [XCTestExpectation]) {
        XCTFail("Did not fulfil expectations")
    }
}

