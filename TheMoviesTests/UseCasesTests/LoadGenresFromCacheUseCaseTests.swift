//
//  LoadGenresFromCacheUseCaseTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class LoadGenresFromCacheUseCaseTests: QuickSpec {
    override func spec() {
        describe("Use Case") {
            var disposeBag: DisposeBag!
            var genreMemorySpy: GenreMemoryRepositorySpy!
            
            beforeEach {
                disposeBag = DisposeBag()
                genreMemorySpy = GenreMemoryRepositorySpy()
            }
            
            afterEach {
                disposeBag = nil
                genreMemorySpy = nil
            }
            
            describe("Logic") {
                it("Carrega todos os filmes favoritados do cache") {
                    let useCase = LoadGenresFromCacheUseCase(memoryRepository: genreMemorySpy)
                    
                    waitUntil { done in
                        useCase.resultStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run()
                    }
                    
                    expect(genreMemorySpy.callGetAllCount) == 1
                }
            }
        }
    }
}
