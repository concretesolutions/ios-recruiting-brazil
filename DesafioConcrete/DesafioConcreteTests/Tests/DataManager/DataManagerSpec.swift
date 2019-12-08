//
//  DataManagerSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class DataManagerSpec: XCTestCase {

    func testIfSaveandCheckAreWorking() {
        let movie = Movie(popularity: 0.0, voteCount: 1, video: false, posterPath: "", id: 2222, adult: false, backdropPath: "", originalLanguage: "", originalTitle: "", genreIds: [1], title: "Frozen II", voteAverage: 1.0, overview: "", releaseDate: "")
        DataManager.shared.createData(movie: movie)
        XCTAssertTrue(DataManager.shared.checkData(movieId: movie.id))
    }
    
    func testIfDeleteDataIsWorking() {
        let movie = Movie(popularity: 0.0, voteCount: 1, video: false, posterPath: "", id: 1111, adult: false, backdropPath: "", originalLanguage: "", originalTitle: "", genreIds: [1], title: "Frozen II", voteAverage: 1.0, overview: "", releaseDate: "")
        DataManager.shared.createData(movie: movie)
        DataManager.shared.deleteData(movieId: movie.id)
        XCTAssertFalse(DataManager.shared.checkData(movieId: movie.id))
    }
}
