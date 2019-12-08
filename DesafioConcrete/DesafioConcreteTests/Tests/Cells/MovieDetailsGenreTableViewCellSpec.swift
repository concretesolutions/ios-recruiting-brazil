//
//  MovieDetailsGenreTableViewCellSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class MovieDetailsGenreTableViewCellSpec: XCTestCase {
    
    func testIdentifier() {
        XCTAssertTrue(MovieDetailsGenreTableViewCell.identifier() == "movieGenreCell")
    }
}
