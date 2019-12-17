//
//  FavoriteCellSpec.swift
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

class FavoriteMovieCellSpec: QuickSpec {
    override func spec() {
        describe("FavoriteCell") {
            var cell: FavoriteMovieCell!
            
            beforeEach {
                
            }
            
            it("should have a cool layout") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "FavoriteMovieCell"))
            }
        }
    }
}
