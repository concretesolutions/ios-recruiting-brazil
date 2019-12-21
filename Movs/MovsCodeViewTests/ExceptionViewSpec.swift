//
//  ExceptionViewSpec.swift
//  MovsCodeViewTests
//
//  Created by Carolina Cruz Agra Lopes on 20/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class ExceptionViewSpec: QuickSpec {

    // MARK: - Sut

    private var sut: ExceptionView!

    // MARK: - Tests

    override func spec() {
        describe("ErrorView") {
            context("error") {
                beforeEach {
                    self.sut = ExceptionView.error
                    self.sut.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                }

                afterEach {
                    self.sut = nil
                }

                it("should have the expected look and feel") {
                    expect(self.sut) == snapshot("ExceptionView_error")
                }
            }

            context("empty search") {
                beforeEach {
                    self.sut = ExceptionView.emptySearch
                    self.sut.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    DataProvider.shared.reset()
                }

                afterEach {
                    self.sut = nil
                }

                it("should have the expected look and feel") {
                    expect(self.sut) == snapshot("ExceptionView_emptySearch")
                }
            }

            context("empty favorites") {
                beforeEach {
                    self.sut = ExceptionView.emptyFavorites
                    self.sut.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    DataProvider.shared.reset()
                }

                afterEach {
                    self.sut = nil
                }

                it("should have the expected look and feel") {
                    expect(self.sut) == snapshot("ExceptionView_emptyFavorites")
                }
            }
        }
    }
}
