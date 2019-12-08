//
//  MovieDetailsReleaseDateTableViewCellSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class MovieDetailsReleaseDateTableViewCellSpec: XCTestCase {
    
    func testIdentifier() {
        XCTAssertTrue(MovieDetailsReleaseDateTableViewCell.identifier() == "movieReleaseDateCell")
    }
}
