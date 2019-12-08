//
//  Desafio_ConcreteTests.swift
//  Desafio ConcreteTests
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import XCTest
@testable import Desafio_Concrete

class Desafio_ConcreteTests: XCTestCase {

   var requestAPI: RequestAPI!
    var filme: Filme!

    override func setUp() {
        super.setUp()
        requestAPI = RequestAPI()
    }

    override func tearDown() {
        requestAPI = nil
        filme = nil
        super.tearDown()
    }
    
    func testPuxarFilmes(){
        requestAPI.pegarFilmesPopulares(pagina: 1) { result in
            switch result {
            case .success(let filmes):
                 XCTAssertGreaterThan(filmes.count, 0, "deve puxar mais 1 de um filme")
            case .failure( _): break
            }
        }
    }
    
    func testPuxarGeneros(){
        requestAPI.baixarGeneros { (generosDetalhados) in
            XCTAssertNotNil(generosDetalhados)
        }
    }
    
    func testPuxarFilmePorId(){
        //tentando puxar o filme Joker(2019)
        requestAPI.pegarFilmesPorID(id: 475557) { result in
            switch result {
            case .success(let filme):
                 filme.verificarGenerosFilme(generosID: self.filme.filmeDecodable.genre_ids ?? []) { (generos) in
                     XCTAssertGreaterThan(generos.count, 0)
                 }
            case .failure( _): break
            }
        }
    }
    
    func testBaseURL(){
        XCTAssertNotNil(requestAPI.setupBaseURL(fimURL: "testeURL"))
    }
}
