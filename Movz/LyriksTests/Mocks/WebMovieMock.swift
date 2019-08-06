//
//  WebMovieMock.swift
//  LyriksTests
//
//  Created by Eduardo Pereira on 04/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import Foundation

import Foundation

@testable import Lyriks

class WebMovieMock {
    var mock: [WebMovie]
    init() {
        self.mock = [WebMovie(vote_count: 3, id: 1, video: false, vote_average: 7.2, title: "First", popularity: 7.3, poster_path: nil, original_language: nil, original_title: nil, genre_ids: [1], backdrop_path: nil, adult: false, overview: "none", release_date: "1000-11-14"),WebMovie(vote_count: 3, id: 2, video: false, vote_average: 7.2, title: "Second", popularity: 3, poster_path: nil, original_language: nil, original_title: nil, genre_ids: [2], backdrop_path: nil, adult: false, overview: "None", release_date: "1111-12-13")]
        
    }
    
}
