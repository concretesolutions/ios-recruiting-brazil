//
//  NewsViewControllerSpecs.swift
//  Globo.comTests
//
//  Created by Vinicius Brito on 02/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Nimble
import Quick
@testable import Concrete

class NewsViewControllerSpecs: QuickSpec {
    override func spec() {
        var sut: DetailsViewController!
        describe("The Details View Controller'") {
            context("Mostrar os dados oriundos do JSON localmente") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    sut = DetailsViewController()
                    _ = sut.view

                    if let path = Bundle(for: type(of: self)
                        ).path(forResource: "test",
                               ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                                options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(Movies.self, from: data)
                            let movies = response.results
                            sut.viewModel = MovieViewModel(item: movies[0])

                        } catch {
                            fail("Erro no JSON")
                        }
                    }
                }

                it("Checagem da url a ser exibida") {
                    expect(sut.viewModel?.title).toEventuallyNot(beNil() && beEmpty())
                }
            }
        }
    }
}
