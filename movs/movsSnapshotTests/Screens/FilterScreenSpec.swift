//
//  FilterScreenSpec.swift
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

class FilterScreenSpec: QuickSpec {
    override func spec() {
        describe("FilterScreen") {
            var cell: FilterScreen!
            
            beforeEach {
                
            }
            
            it("should have a filter selected") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "MovieCell"))
            }
            
            it("shouldn't have a filter selected") {
                // let view = ...  some view you want to test
                expect(view).to(haveValidSnapshot(named: "MovieCell"))
            }
        }
    }
}
