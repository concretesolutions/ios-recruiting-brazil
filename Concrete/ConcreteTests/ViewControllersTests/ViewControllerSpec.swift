//
//  ViewControllerSpec.swift
//  Concrete
//
//  Created by Vinicius Brito on 22/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Nimble
import Quick
@testable import Concrete

class ViewControllerSpecs: QuickSpec {
    override func spec() {
        var sut: MoviesViewController!
        describe("The Home View Controller'") {
            context("Mostrar os dados oriundos do serviço") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    sut = storyboard.instantiateViewController(
                        withIdentifier: "MoviesViewController") as? MoviesViewController

                    _ = sut.view
                }

                it("Checagem do número de células") {
                    expect(sut.collectionViewMovies.numberOfItems(inSection: 0)).toEventually(beGreaterThan(3))
                }

                it("Checagem se a primeira célula possúi título") {
                    print(sut.collectionViewMovies.numberOfItems(inSection: 0))
                    let indexPath = IndexPath(row: 0, section: 0)
                    if let cell = sut.collectionViewMovies.cellForItem(at: indexPath) as? MovieCell {
                        expect(cell.labelTitle.text).toEventuallyNot(beNil() && beEmpty())
                    }
                }
            }
        }
    }
}
