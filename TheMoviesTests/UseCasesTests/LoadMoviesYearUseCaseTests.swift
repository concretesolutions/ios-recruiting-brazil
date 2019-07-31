//
//  LoadMoviesYearUseCaseTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import RxSwift
import Nimble
@testable import TheMovies

class LoadMoviesYearUseCaseTests: QuickSpec {
    override func spec() {
        describe("Use Case") {
            var spy: MovieMemoryRepositorySpy!
            
            beforeEach {
                spy = MovieMemoryRepositorySpy()
            }
            
            afterEach {
                spy = nil
            }
            
            describe("Logic") {
                it("Carrega todos os filmes da memória") {
                    let useCase = LoadMoviesYearUseCase(memoryRepository: spy)
                    
                    _ = useCase.run()
                    
                    expect(spy.callGetMoviesYearCount) == 1
                }
            }
        }
    }
    
}
