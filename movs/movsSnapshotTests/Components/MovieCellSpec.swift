//
//  MovieCellSpec.swift
//  movsSnapshotTests
//
//  Created by Emerson Victor on 17/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import Movs

class MovieCellSpec: QuickSpec {
    override func spec() {
        describe("MovieCell") {
            var cell: MovieCell!
            
            beforeEach {
                
            }
            
            it("shouldn't be favorite") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "MovieCell"))
            }
            
            it("should be favorite") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "MovieCellFavorited"))
            }
        }
    }
}
