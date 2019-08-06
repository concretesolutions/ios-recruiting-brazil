//
//  MovieMock.swift
//  LyriksTests
//
//  Created by Eduardo Pereira on 04/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import Foundation

import Foundation

@testable import Lyriks

class MovieMock {
    
    var mock: [Movie]
    
    init() {
        
        self.mock = [Movie(image: nil, id: "0", title: "first", vote_average: "7", genres: [1], release_date: "1000-11-12", overview: "none", poster_path: ""),Movie(image: nil, id: "1", title: "second", vote_average: "9", genres: [2], release_date: "1111-13-14", overview: "", poster_path: "")]
    
    }
    
}
