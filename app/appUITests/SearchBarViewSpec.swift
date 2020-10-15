//
//  SearchBarViewSpec.swift
//  appUITests
//
//  Created by rfl3 on 15/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import Nimble_Snapshots
import Quick
import UIKit
import Nimble

@testable import app

class SearchBarViewSpec: QuickSpec {

    override func spec() {
        describe("test 'SearchBarView'") {
            it(""){
                let frame = CGRect(x: 0, y: 0, width: 414, height: 44)
                let view = SearchBarView(frame: frame)
                expect(view) == snapshot("SearchBarView")
            }
        }
    }

}
