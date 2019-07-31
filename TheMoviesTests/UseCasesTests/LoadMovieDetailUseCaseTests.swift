//
//  LoadMovieDetailUseCaseTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class LoadMovieDetailUseCaseTests: QuickSpec {
    override func spec() {
        describe("Use Case") {
            var disposeBag: DisposeBag!
            var spy: MovieMemoryRepositorySpy!
            
            beforeEach {
                disposeBag = DisposeBag()
                spy = MovieMemoryRepositorySpy()
            }
            
            afterEach {
                disposeBag = nil
                spy = nil
            }
            
            describe("Logic") {
                it("Carrega os detalhes de um filme") {
                    let useCase = LoadMovieDetailUseCase(memoryRepository: spy)
                    
                    waitUntil { done in
                        useCase.resultStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run(0)
                    }
                    
                    expect(spy.callGetMoviesFromIdCount) == 1
                }
            }
        }
    }
}
