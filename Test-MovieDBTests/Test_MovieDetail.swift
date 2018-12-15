//
//  Test_MovieDetail.swift
//  Test-MovieDBTests
//
//  Created by Gabriel Soria Souza on 12/12/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import XCTest
@testable import Test_MovieDB

class Test_MovieDetail: XCTestCase {

    let detailVC = MovieDetailViewController()
    var detailMiddle: MovieDetailMiddle!
    
    
    override func setUp() {
        detailMiddle = MovieDetailMiddle(delegate: detailVC as MovieDetailMiddleDelegate)
        detailVC.middle = detailMiddle
    }

    override func tearDown() {
        
    }

    func test_notificationReceivedAfterSavingMovie() {
        //given
        let movieDetail = MovieDetailWorker(posterPath: "2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg", title: "Venom", genreID: [878], yearOfRelease: "2018-10-03", isFavorite: true, description: "Eddie Brock is a reporter—investigating people who want to go unnoticed. But after he makes a terrible discovery at the Life Foundation, he begins to transform into ‘Venom’.  The Foundation has discovered creatures called symbiotes, and believes they’re the key to the next step in human evolution. Unwittingly bonded with one, Eddie discovers he has incredible new abilities—and a voice in his head that’s telling him to embrace the darkness.", id: 335983)
        let expectation = XCTNSNotificationExpectation(name: .didReceiveData)
        
        //when
        detailMiddle.savedMovie(movie: movieDetail)
        
        //then
        wait(for: [expectation], timeout: 3)
        
        
    }
    

}
