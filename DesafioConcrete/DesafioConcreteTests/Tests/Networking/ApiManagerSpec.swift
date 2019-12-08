//
//  ApiManager.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class ApiManagerSpec: XCTestCase {
    
    func testRequestGenres() {
        let promise = expectation(description: "Genres received")
        
        ApiManager.getGenres(success: { data in
            do {
                let _ = try JSONDecoder().decode(GenreRoot.self, from: data)
                promise.fulfill()
            } catch {
                XCTFail("StatusCode != 200")
            }
        }) { (error) in
            XCTFail("\(error)")
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testRequestMovies() {
        let promise = expectation(description: "Movies page 1 received")
        
        ApiManager.getMovies(page: 1, success: { data in
            do {
                let _ = try JSONDecoder().decode(MovieRoot.self, from: data)
                promise.fulfill()
            } catch {
                XCTFail("StatusCode != 200")
            }
        }) { (error) in
            XCTFail("\(error)")
        }
        
        wait(for: [promise], timeout: 5)
    }
}
