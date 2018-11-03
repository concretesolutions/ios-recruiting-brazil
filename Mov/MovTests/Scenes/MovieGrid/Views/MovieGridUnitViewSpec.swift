//
//  MovieGridUnitViewSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class MovieGridUnitViewSpec: QuickSpec {
    override func spec() {
        var view: MovieGridUnitView!
        describe("MovieGridUnitView") {
            context("when initialized") {
                beforeEach {
                    view = MovieGridUnitView(frame: .zero)
                }
                
                it("add own subviews") {
                    expect(view.subviews).to(contain([view.poster, view.title, view.favoriteButton]))
                }
            }
        }
    }
}
