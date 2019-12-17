//
//  MoviesScreenSpec.swift
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

class MoviesScreenSpec: QuickSpec {
    override func spec() {
        describe("MoviesScreen") {
            var cell: MoviesScreen!
            
            beforeEach {
                
            }
            
            it("should have a cool layout") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "FavoriteCell"))
            }
            
            it("should be loading") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "MovieCell"))
            }
            
            it("should be filtered with search and have content") {
                
            }
            
            it("should be filtered with search and have no content") {
                
            }
            
            it("should show error") {
                
            }
        }
    }
}
