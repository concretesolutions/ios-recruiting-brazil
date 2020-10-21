//
//  GridCollectionViewCellSpec.swift
//  appUITests
//
//  Created by rfl3 on 20/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import Nimble_Snapshots
import Quick
import UIKit
import Nimble

@testable import app

class GridCollectionViewCellSpec: QuickSpec {

    override func spec() {
        describe("test 'GridCollectionViewCell'") {
            it(""){
                let frame = CGRect(x: 0, y: 0, width: 200, height: 300)
                let view = GridCollectionViewCell(frame: frame)
                expect(view) == snapshot("GridCollectionViewCell")
            }
        }
    }

}
