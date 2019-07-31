//
//  LoadMoviesFromCacheUseCaseTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class LoadMoviesFromCacheUseCaseTests: QuickSpec {
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
                it("Carrega todos os filmes da memória") {
                    let useCase = LoadMoviesFromCacheUseCase(memoryRepository: spy)
                    
                    waitUntil { done in
                        useCase.moviesLoadedStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run()
                    }
                    
                    expect(spy.callGetAllMoviesCount) == 1
                }
            }
        }
    }
}
