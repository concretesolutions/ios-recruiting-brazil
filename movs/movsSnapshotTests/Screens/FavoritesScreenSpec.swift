//
//  FavoritesScreenSpec.swift
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

class FavoritesScreenSpec: QuickSpec {
    override func spec() {
        describe("FavoritesScreen") {
            var cell: FavoritesScreen!
            
            beforeEach {
                
            }
            
            it("should have no favorites") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "MovieCell"))
            }
            
            it("should be loading") {
                
            }
            
            it("should have favorites") {
                
            }
            
            it("should be filtered by date and genre") {
                
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
