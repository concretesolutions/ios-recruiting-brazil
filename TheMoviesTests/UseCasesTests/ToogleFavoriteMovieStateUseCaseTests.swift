//
//  ToogleFavoriteMovieStateUseCase.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//
import Quick
import Nimble
import RxSwift
@testable import TheMovies

class ToogleFavoriteMovieStateUseCaseTests
: QuickSpec {
    override func spec() {
        describe("Use Case") {
            var disposeBag: DisposeBag!
            var memorySpy: MovieMemoryRepositorySpy!
            
            beforeEach {
                disposeBag = DisposeBag()
                memorySpy = MovieMemoryRepositorySpy(with: MovieStoreMock())
            }
            
            afterEach {
                disposeBag = nil
                memorySpy = nil
            }
            
            describe("Logic") {
                it("Troca o estado de favorito de um filme") {
                    let useCase = ToogleFavoriteMovieStateUseCase(memoryRepository: memorySpy)
                    
                    waitUntil { done in
                        useCase.resultStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run(0)
                    }
                    
                    expect(memorySpy.callSetFavoriteMovieCount) == 1
                }
            }
        }
    }
}
