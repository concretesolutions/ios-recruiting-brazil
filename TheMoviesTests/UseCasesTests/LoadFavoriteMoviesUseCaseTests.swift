//
//  LoadFavoriteMoviesUseTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class LoadFavoriteMoviesUseTests: QuickSpec {
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
                it("Carrega todos os filmes favoritados") {
                    let useCase = LoadFavoriteMoviesUseCase(memoryRepository: spy)
                    
                    waitUntil { done in
                        useCase.resultStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run()
                    }
                    
                    expect(spy.callGetAllFavoriteMoviesCount) == 1
                }
            }
        }
    }
    
}
