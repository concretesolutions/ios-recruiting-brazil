//
//  MovieDetailsViewControllerSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class MovieDetailsViewControllerSpec: XCTestCase {
    
    func testSetup() {
        let movie = Movie(popularity: 0.0, voteCount: 1, video: false, posterPath: "", id: 1111, adult: false, backdropPath: "", originalLanguage: "", originalTitle: "", genreIds: [1], title: "Frozen II", voteAverage: 1.0, overview: "", releaseDate: "")
        let vc = MovieDetailsRouter.createModule(movie: movie)
        _ = vc.view
    }

}
