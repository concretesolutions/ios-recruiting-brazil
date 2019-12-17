//
//  DetailPresenterTests.swift
//  ConcreteChallengeTests
//
//  Created by Alexandre Abrahão on 16/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import XCTest
@testable import Movs

class DetailPresenterTests: XCTestCase {
    
    var movieMock: Movie!
    var sut: DetailPresenter!
    var delegate: DetailViewDelegate!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieMock = Movie(id: 330457,
                          title: "Frozen II",
                          overview: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
                          genreIDs: [12, 16, 10402, 10751],
                          posterPath: "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg",
                          backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
                          releaseDate: "2019-11-20")
        sut = DetailPresenter(movie: movieMock)
        delegate = DetailViewDelegateMock()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieMock = nil
        sut = nil
        delegate = nil
    }

    func testViewData() {
        
        // given
        let infoType: DetailInfoType
        
        // when
        infoType = sut.getDetailInfo(row: 1)
        
        // then
        switch infoType {
        case .title(let title):
            XCTAssertTrue(title == movieMock.title)
        default:
            XCTFail("Error: Wrong info type")
        }
    }
}
