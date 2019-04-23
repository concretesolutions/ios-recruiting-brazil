//
//  NewsSpecs.swift
//  Concrete
//
//  Created by Vinicius Brito on 22/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Quick
import Nimble
@testable import Concrete

class GamesSpecs: QuickSpec {
    override func spec() {
        var sut: Movies!
        describe("Lista de filmes") {
            context("Verificação do JSON") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    if let path = Bundle(for: type(of: self)
                        ).path(forResource: "test",
                               ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                                options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            sut = try decoder.decode(Movies.self, from: data)
                        } catch {
                            fail("Erro no JSON")
                        }
                    }
                }
                it("Verifica o número de itens") {
                    expect(sut.results.count).to(equal(20))
                }

                it("Verifica o título do item") {
                    expect(sut.results[8].title).toEventuallyNot(beNil())
                }

                it ("Verifica o lançamento") {
                    expect(sut.results[17].releaseDate).toEventuallyNot(beNil())
                }

                it ("Verifica a url da imagem") {
                    expect(sut.results[2].posterPath).toEventuallyNot(beNil())
                }
            }
        }
    }
}
