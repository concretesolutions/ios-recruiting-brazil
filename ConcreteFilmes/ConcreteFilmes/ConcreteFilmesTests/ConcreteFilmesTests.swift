//
//  ConcreteFilmesTests.swift
//  ConcreteFilmesTests
//
//  Created by Luis Felipe Tapajos on 06/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import XCTest
@testable import ConcreteFilmes

class ConcreteFilmesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoadFilmes() {
        FilmesViewModel.shared.loadFilmes(completionHandler: { result in
            if (result.count > 0) {
                XCTAssert(true)
            }
        })
    }
    
    func testTrataAnoValido() {
        let dateYear = Help.shared.formatYear(date: "2020-10-16")
        XCTAssertEqual(dateYear, "2020")
    }
    
    func testTrataAnoInvalido() {
        let dateYear = Help.shared.formatYear(date: "10-10-16")
        XCTAssertNotEqual(dateYear, "2020")
    }
    
    func testFormatGenre() {
        var listaGeneros = ""
        let generoLista = ["Ação", "Comédia"]
        for genero in generoLista {
            listaGeneros += "\(Help.shared.formatGenre(generos: [genero])), "
        }
        XCTAssertEqual(listaGeneros.dropLast(2), "Ação, Comédia")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
