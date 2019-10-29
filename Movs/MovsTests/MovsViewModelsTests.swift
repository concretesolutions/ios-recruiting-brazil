//
//  MovsViewModelsTests.swift
//  MovsTests
//
//  Created by Bruno Barbosa on 29/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import XCTest
@testable import Movs

class MovsViewModelsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPosterImageFetching() {
        let movie = Movie(id: 76341, title: "Mad Max: Fury Road", posterPath: "/kqjL17yufvn9OVLyXYpvtyrFfak.jpg", releaseDateStr: "2015-05-13", genreIds: [28, 12, 878, 53], overview: "An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order. There's Max, a man of action and a man of few words, who seeks peace of mind following the loss of his wife and child in the aftermath of the chaos. And Furiosa, a woman of action and a woman who believes her path to survival may be achieved if she can make it across the desert back to her childhood homeland.")
        
        let posterImgViewModel = PosterImageViewModel(with: movie)
        
        let promise = expectation(description: "Movie image fetches successfully")
        
        posterImgViewModel.fetchPoster { (returnedImg) in
            let placeholder = UIImage(named: "poster_placeholder")
            XCTAssertNotEqual(placeholder, returnedImg, "Images are equal")
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }

}
