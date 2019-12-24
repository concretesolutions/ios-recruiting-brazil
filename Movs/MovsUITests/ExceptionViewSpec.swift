//
//  ExceptionViewSpec.swift
//  MovsUITests
//
//  Created by Lucca França Gomes Ferreira on 23/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class ExceptionViewSpec: QuickSpec {

    override func spec() {
        var exceptionView: ExceptionView!
        describe("ExceptionView") {
            context("when state is withoutNetwork") {
                beforeEach {
                    exceptionView = ExceptionView(frame: CGRect(x: 0, y: 0, width: 414, height: 896))
                    exceptionView.state = .withoutNetwork
                }
                it("should have the expected look and feel.") {
                    expect(exceptionView) == snapshot("ExceptionView_withoutNetwork")
                }
            }
            context("when state is searchNoData") {
                beforeEach {
                    exceptionView = ExceptionView(frame: CGRect(x: 0, y: 0, width: 414, height: 896))
                    exceptionView.state = .searchNoData
                }
                it("should have the expected look and feel.") {
                    expect(exceptionView) == snapshot("ExceptionView_searchNoData")
                }
            }
            context("when state is noFavorites") {
                beforeEach {
                    exceptionView = ExceptionView(frame: CGRect(x: 0, y: 0, width: 414, height: 896))
                    exceptionView.state = .noFavorites
                }
                it("should have the expected look and feel.") {
                    expect(exceptionView) == snapshot("ExceptionView_noFavorites")
                }
            }
            context("when state is firstLoading") {
                beforeEach {
                    exceptionView = ExceptionView(frame: CGRect(x: 0, y: 0, width: 414, height: 896))
                    exceptionView.state = .firstLoading
                }
                it("should have the expected look and feel.") {
                    expect(exceptionView) == snapshot("ExceptionView_firstLoading")
                }
            }
            context("when state is any other") {
                beforeEach {
                    exceptionView = ExceptionView(frame: CGRect(x: 0, y: 0, width: 414, height: 896))
                    exceptionView.state = .none
                }
                it("should have the expected look and feel.") {
                    expect(exceptionView) == snapshot("ExceptionView")
                }

            }
            
        }
    }
    
}
