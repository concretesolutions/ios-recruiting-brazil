//
//  LoadMoviesFromNetworkAndCacheUseCaseTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class LoadMoviesFromNetworkAndCacheUseCaseTests: QuickSpec {
    override func spec() {
        describe("Use Case") {
            var movieMemorySpy: MovieMemoryRepositorySpy!
            var movieNetworkSpy: MovieNetworkRepositorySpy!
            var genreMemorySpy: GenreMemoryRepositorySpy!
            var disposeBag: DisposeBag!
            
            beforeEach {
                movieMemorySpy = MovieMemoryRepositorySpy()
                movieNetworkSpy = MovieNetworkRepositorySpy()
                genreMemorySpy = GenreMemoryRepositorySpy()
                disposeBag = DisposeBag()
            }
            
            afterEach {
                movieMemorySpy = nil
                movieNetworkSpy = nil
                genreMemorySpy = nil
                disposeBag = nil
            }
            
            describe("Logic") {
                it("Carrega todos os filmes da API") {
                    let convertUseCase = ConvertMovieEntityToModelUseCase(genreMemoryRepository: genreMemorySpy)
                    let useCase = LoadMoviesFromNetworkAndCacheUseCase(memoryRepository: movieMemorySpy, networkRepository: movieNetworkSpy, convertMovieEntityToModelUseCase: convertUseCase)
                    
                    waitUntil { done in
                        useCase.moviesLoadedStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run()
                    }
                    
                    expect(movieNetworkSpy.callGetMoviesCount) == 1
                }
                
                it("Tenta Carregar todos os filmes da API, mas verifica que já estão carregados") {
                    let convertUseCase = ConvertMovieEntityToModelUseCase(genreMemoryRepository: genreMemorySpy)
                    let useCase = LoadMoviesFromNetworkAndCacheUseCase(memoryRepository: movieMemorySpy, networkRepository: movieNetworkSpy, convertMovieEntityToModelUseCase: convertUseCase)
                    
                    waitUntil { done in
                        useCase.moviesLoadedStream.subscribe(onNext: { _ in
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run()
                    }
                    
                    expect(movieNetworkSpy.callGetMoviesCount) == 1
                }
            }
        }
    }
    
}
