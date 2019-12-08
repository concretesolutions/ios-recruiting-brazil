//
//  ConfigGenreSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class ConfigGenreSpec: XCTestCase {
    
    func testAssigningGenreIdsToStrings() {
        
        let allGenres: [Genre] = [Genre(id: 16, name: "Animation"), Genre(id: 10402, name: "Family"), Genre(id: 10751, name: "Music"), Genre(id: 35, name: "Comedy")]
        let genres: [Int] = [16, 10402, 10751]
        var genresString: [String] = []
        for genre in allGenres where genres.contains(genre.id) {
            genresString.append(genre.name)
        }
        
        var genresDescribed: String = ""
        for genre in genresString {
            if genre == genresString.last {
                genresDescribed += "\(genre)"
            } else {
                genresDescribed += "\(genre), "
            }
        }
        XCTAssertTrue(genresDescribed == "Animation, Family, Music")
    }
}
