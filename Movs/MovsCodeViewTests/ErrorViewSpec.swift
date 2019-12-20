//
//  ErrorViewSpec.swift
//  MovsCodeViewTests
//
//  Created by Carolina Cruz Agra Lopes on 20/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class ErrorViewSpec: QuickSpec {

    // MARK: - Sut

    private var sut: ErrorView!

    // MARK: - Tests

    override func spec() {
        describe("ErrorView") {
            context("get popular movies error") {
                beforeEach {
                    self.sut = ErrorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), imageSystemName: "xmark.circle.fill", text: "An error occurred. Please try again later.")
                }

                afterEach {
                    self.sut = nil
                }

                it("should have the expected look and feel") {
                    expect(self.sut) == snapshot("ErrorView_popular")
                }
            }

            context("search error") {
                beforeEach {
                    self.sut = ErrorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), imageSystemName: "magnifyingglass.circle.fill", text: "Sorry, we couldn't find any movie with \"x\"")
                    DataProvider.shared.reset()
                }

                afterEach {
                    self.sut = nil
                }

                it("should have the expected look and feel") {
                    expect(self.sut) == snapshot("ErrorView_search")
                }
            }
        }
    }
}
