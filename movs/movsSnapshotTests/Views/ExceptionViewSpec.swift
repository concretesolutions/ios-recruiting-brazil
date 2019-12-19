//
//  ExceptionViewSpec.swift
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

class ExceptionViewSpec: QuickSpec {
    override func spec() {
        describe("ExceptionViewSpec") {
            var view: ExceptionView!
            
            it("should show generic error") {
                view = ExceptionView(type: .error)
                view.frame = CGRect(x: 0, y: 0, width: 414, height: 813)
                expect(view).to(haveValidSnapshot(named: "ExceptionViewError"))
            }
            
            it("should show empty search error") {
                view = ExceptionView(type: .emptySearch)
                view.frame = CGRect(x: 0, y: 0, width: 414, height: 813)
                expect(view).to(haveValidSnapshot(named: "ExceptionViewEmptySearch"))
            }
        }
    }
}
