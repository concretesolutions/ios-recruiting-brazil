//
//  ListMoviesViewControllerSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class ListMoviesViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: ListMoviesViewController!
        var presenter: ListMoviesPresentationMock!
        
        beforeEach {
            sut = ListMoviesViewController()
            presenter = ListMoviesPresentationMock()
            sut.presenter = presenter
        }
        
        
        
    }
}
