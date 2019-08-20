//
//  FilterSanpshot.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/20/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class FilterSnapshot: QuickSpec{

    override func spec() {
        describe("Filter Screen Visual check") {
            it("Should look like this"){
                let frame = UIScreen.main.bounds
                let view =  FilterView(frame: frame)
                expect(view) == snapshot("FilterView")
            }
        }
    }
}
