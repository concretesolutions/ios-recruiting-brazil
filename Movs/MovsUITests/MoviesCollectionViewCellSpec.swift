//
//  MoviesCollectionViewCellSpec.swift
//  MovsUITests
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class MoviesCollectionViewCellSpec: QuickSpec {

    override func spec() {
        var moviesCollectionViewCell: MoviesCollectionViewCell!
        describe("MoviesCollectionViewCell") {
            beforeEach {
                moviesCollectionViewCell = MoviesCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            }
            context("unselected") {
                it("should look right") {
                    expect(moviesCollectionViewCell == recordSnapshot())
                }
            }
        }
    }

}
