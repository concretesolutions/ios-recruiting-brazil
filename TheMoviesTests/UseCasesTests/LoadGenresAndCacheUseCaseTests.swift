//
//  LoadGenresAndCacheUseCaseTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class LoadGenresAndCacheUseCaseTests: QuickSpec {
    
    override func spec() {
        describe("Use Case") {
            var disposeBag: DisposeBag!
            var genreMemorySpy: GenreMemoryRepositorySpy!
            var genreNetworkSpy: GenreNetworkRepositorySpy!
            
            beforeEach {
                disposeBag = DisposeBag()
                genreMemorySpy = GenreMemoryRepositorySpy()
                genreNetworkSpy = GenreNetworkRepositorySpy()
            }
            
            afterEach {
                disposeBag = nil
                genreMemorySpy = nil
                genreNetworkSpy = nil
            }
            
            describe("Logic") {
                it("Carrega os generos da API e os guarda em Cache") {
                    let useCase = LoadGenresAndCacheUseCase(memoryRepository: genreMemorySpy, networkRepository: genreNetworkSpy)
                    
                    waitUntil { done in
                        useCase.genresLoadedStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run()
                    }
                    
                    expect(genreNetworkSpy.callGetGenresCount) == 1
                    expect(genreMemorySpy.callCacheCount) == 1
                }
            }
        }
    }
    
}
